import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/utils/local_storage.dart';

var BASE = dotenv.get('BASE_SERVER_URL');
Future<Map<String, dynamic>> checkIsSignedIn(token) async {
  try {
    var res = await Dio().post('$BASE/login/isLoggedIn',
        data: {"token": token},
        options: Options(
            contentType: "application/json",
            validateStatus: (status) {
              return status! < 500;
            }));

    if (res.data == null || res.statusCode != 200) {
      return {"status": "UnAuthorize", "message": "User is unauthorized"};
    }

    return {"status": "Authorize", "message": "User is logged in"};
  } catch (e) {
    return {"status": "Error", "message": e.toString()};
  }
}

Future<Map<String, dynamic>> quickLogIn() async {
  var localUser = await getLocalUser();
  try {
    var res = await Dio().post('$BASE/login/quick',
        data: {
          "username": localUser['username'],
          "password": localUser['password']
        },
        options: Options(
            contentType: "application/json",
            validateStatus: (status) {
              return status! < 500;
            }));

    if (res.statusCode != 200) {
      return {"status": "fail", "message": res.data['message']};
    }
    var authorized = Map<String, dynamic>.from(res.data['authorized']);

    return {"status": "success", "authorized": json.encode(authorized)};
  } catch (e) {
    return {"status": "error", "message": e.toString()};
  }
}
