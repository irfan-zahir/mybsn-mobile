
import 'package:mobile/api/base_api.dart';
import 'package:mobile/classes/login_state.dart';

Future<Map<String, dynamic>> getDashboardInfo(LoginState loginState)async{
  var res = await authorized_api(loginState).get('/dashboard');
  var data = res.data;
  return Map.from(data);
}

Future <Map<String, dynamic>> getRecentTransactions(LoginState loginState, listNumber)async{
  var res = await authorized_api(loginState).post('/dashboard_history', data: {"listNumber": listNumber});
  return Map.from(res.data);
}