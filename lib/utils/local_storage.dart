import 'package:localstorage/localstorage.dart';
import 'package:mobile/utils/enryptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

LocalStorage storage = LocalStorage('uobsn');
EncryptData encryptData = EncryptData();

void saveLocalAuthorization(String data, username) async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString("Authorization-$username", data);
}

Future<String?> getLocalAuthorization(username) async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  return _prefs.getString('Authorization-$username');
}

void saveLocalUser(String username, String password) async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  var epwd;
  _prefs.setString('username', username);
  if (password.isNotEmpty) {
    epwd = EncryptData.encryptAES(password);
    _prefs.setString('password', epwd);
  }
}

Future<Map<dynamic, dynamic>> getLocalUser() async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  String? epwd = _prefs.getString('password');
  String? username = _prefs.getString('username');
  
  if(epwd ==null && epwd!.isEmpty){
  return {"username": username, "password": epwd};
  }
  return {"username": username, "password":  EncryptData.decryptAES(epwd)};

}

Future<void> setDataExpired() async {
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  var now = DateTime.now();
  _prefs.setString('expired', now.add(const Duration(hours: 12)).toString());
}

Future<bool> isDataExpired()async{
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  var now = DateTime.now();
  String? expired = _prefs.getString('expired');
  if(expired==null){
    return true;
  }
  return now.compareTo(DateTime.parse(expired)) > 0;
}