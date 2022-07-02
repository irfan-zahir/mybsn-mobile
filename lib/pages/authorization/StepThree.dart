import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile/classes/login_state.dart';
import 'package:mobile/utils/local_storage.dart';
import 'package:provider/provider.dart';

class StepThree extends StatefulWidget {
  const StepThree(
      {Key? key,
      required this.updateLoginState,
      required this.currentLoginState})
      : super(key: key);
  final updateLoginState;
  final currentLoginState;

  @override
  State<StepThree> createState() => _StepThreeState();
}

class _StepThreeState extends State<StepThree> {
  bool rememberMe = true;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var state = Map<String, dynamic>.from(widget.currentLoginState['data']);
    var fp = state['__fp'];
    var sourcePage = state['_sourcePage'];
    var cookie = state['Cookie'];
    final passwordController = TextEditingController();

    proceedStepThree(LoginState loginState)async{
      var password = passwordController.text;
      var dio = Dio();
      var api = dotenv.get('BASE_SERVER_URL');
      var username = loginState.username;
      
      if (password.isNotEmpty) {
        try {
          var res = await dio.post('$api/login/password', data: {
            "password": password,
            "Cookie": cookie,
            "__fp": fp,
            "_sourcePage": sourcePage
          });
          var Authorization = Map<String, dynamic>.from(res.data['authorized']);
          saveLocalAuthorization(json.encode(Authorization), username);
          
          saveLocalUser(username, password);
          if(rememberMe) setDataExpired();
          loginState.updateAuthorization(Authorization.toString());
        } catch (e) {
          log('step3'+e.toString());
        }
      }
    }

    return Consumer<LoginState>(
      builder: (ctx, loginState, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                      width: 0.85 * width,
              child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 0.725 * width,
                      child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            hintText: "Enter your password...",
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.all(Radius.circular(16.0))),
                          )),
                    ),
                    
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          // color: Colors.cyan,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: TextButton(
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.cyan,
                        ),
                        onPressed: () async => await proceedStepThree(loginState),
                      ),
                    ),
                  )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 0.85 * width,
              child: CheckboxListTile(
                  value: rememberMe,
                  selected: rememberMe,
                  // side: const BorderSide(color: Colors.cyan),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  // checkboxShape: const RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.all(Radius.circular(4)),
                  // ),
                  title: const Text("Remember me"),
                  // fillColor: MaterialStateColor.resolveWith((states) => Colors.cyan.shade500),
                  activeColor: Colors.cyan.shade500,
                  onChanged: (newValue) {
                    setState(() {
                      rememberMe = !rememberMe;
                    });
                  }),
            ),
            // SizedBox(
            //   width: 0.85 * width,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //         minimumSize: const Size.fromHeight(40), primary: Colors.cyan),
            //     onPressed: () async {
            //       var password = passwordController.text;
            //       var dio = Dio();
            //       var api = dotenv.get('BASE_SERVER_URL');
            //       var username = loginState.username;
                  
            //       if (password.isNotEmpty) {
            //         try {
            //           var res = await dio.post('$api/login/password', data: {
            //             "password": password,
            //             "Cookie": cookie,
            //             "__fp": fp,
            //             "_sourcePage": sourcePage
            //           });
            //           var Authorization = Map<String, dynamic>.from(res.data['authorized']);
            //           saveLocalAuthorization(json.encode(Authorization), username);
                      
            //           saveLocalUser(username, password);
            //           if(rememberMe) setDataExpired();
            //           loginState.updateAuthorization(Authorization.toString());
            //         } catch (e) {
            //           log('step3'+e.toString());
            //         }
            //       }
            //     },
            //     child: const Text('Proceed Sign In'),
            //   ),
            // ),
            SizedBox(
              width: 0.85 * width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                ),
                onPressed: () {
                  widget.updateLoginState({"step": 1, "data": null});
                },
                child: const Text('Cancel'),
              ),
            ),
          ],
        );
      }
    );
  }
}
