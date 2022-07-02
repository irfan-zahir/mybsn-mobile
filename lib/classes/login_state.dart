import 'package:flutter/cupertino.dart';
import 'package:mobile/utils/local_storage.dart';

class LoginState extends ChangeNotifier {
  LoginState({
    required this.username,
    required this.password,
    required this.authorized,
  });

  String username;
  String password;
  String authorized;

  void updateAuthorization(String authorized){
    this.authorized = authorized;
    notifyListeners();
  }

  void updateLocalUser({required String username, String? password}){
    this.username = username;
    if(password!= null) this.password = password;
    saveLocalUser(username, password ??= '');
    notifyListeners();
  }
}
