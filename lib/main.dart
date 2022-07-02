import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile/classes/login_state.dart';
import 'package:mobile/pages/authorized/index.dart';
import 'package:mobile/utils/local_storage.dart';
import 'package:provider/provider.dart';
import './api/auth.dart';
import './pages/authorization/login.dart';
import 'pages/authorized/dashboard/dashboard.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myBSN - Unofficial',
      debugShowCheckedModeBanner: false,
      home: MyBSN(),
    );
  }
}

class MyBSN extends StatefulWidget {
  MyBSN({Key? key}) : super(key: key);

  @override
  State<MyBSN> createState() => _MyBSNState();
}

class _MyBSNState extends State<MyBSN> with WidgetsBindingObserver {
  LoginState isAuthorized =
      LoginState(username: '', password: '', authorized: '');

  bool isLoading = true;
  checkUserAuthorized() async {
    var localUser = await getLocalUser();
    if (localUser['username'] != null) {
      var username = localUser['username'];
      var password = localUser['password'];
      var Authorization = await getLocalAuthorization(username);
      if (Authorization != null) {
        var authorized = await checkIsSignedIn(Authorization);
        if (authorized['status'] == "Error" ||
            authorized['status'] == "UnAuthorize") {
          bool isExpired = await isDataExpired();
          if (!isExpired && Authorization != "unauthorized") {
            quickLogIn().then((res) {
              
              saveLocalAuthorization(res['authorized'], username);

              setState(() => isAuthorized = LoginState(
                  username: username,
                  password: password,
                  authorized: res['authorized']));
            });
          } else {
            setState(() {
              isAuthorized = LoginState(
                  username: username, password: password, authorized: '');
            });
          }
        } else {
          setState(() => isAuthorized = LoginState(
              username: username,
              password: password,
              authorized: Authorization));
        }
      } else {
        setState(() => isAuthorized = isAuthorized);
      }
    } else {
      setState(() => isAuthorized = isAuthorized);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    checkUserAuthorized();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    if (state == AppLifecycleState.paused) log('pausef');

    if (state == AppLifecycleState.resumed) {
      checkUserAuthorized();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider<LoginState>.value(
          value: isAuthorized,
          child: Consumer<LoginState>(
            builder: (context, loginState, child) {
              if (loginState.authorized.isNotEmpty && loginState.authorized != 'unauthorized') return const LandingPage();
              return LoginScreen();
            },
          ),
        ));
  }
}
