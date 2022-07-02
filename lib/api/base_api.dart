import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/classes/login_state.dart';
import 'package:mobile/utils/local_storage.dart';

var base_url = dotenv.get('BASE_SERVER_URL');

Dio authorized_api(LoginState loginState) {
  var options = BaseOptions(
    baseUrl: '$base_url/authorized',
    contentType: 'application/json',
    validateStatus: (status){
      if( status! < 501) {
        return true;
      }else{
        return false;
      }
    }
  );
  var dio = Dio(options);
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      var currentUser = await getLocalUser();
      var token = await getLocalAuthorization(currentUser['username']);
      options.headers = {'authorization': token};
      return handler.next(options);
    },
    onResponse: (response, handler) async {
      var currentUser = await getLocalUser();
      var auth = response.headers['authorization']![0];
      saveLocalAuthorization(auth, currentUser['username']);
      loginState.updateAuthorization(auth);
      handler.next(response);
    },
  ));
  return dio;
}
