import 'package:flutter/material.dart';
import 'package:mobile/pages/authorization/StepOne.dart';
import 'package:mobile/pages/authorization/StepThree.dart';
import 'package:mobile/pages/authorization/StepTwo.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    Map<String, dynamic>? loginState;
    @override
    void initState() {
      super.initState();
      loginState ??= loginState = {"step": 1, "data": null};
    }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.cyan.shade50,
      child: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Column(
                children: [
                  const Text(
                    'myBSN',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontSize: 55,
                        fontFamily: 'SulphurPoint',
                        color: Colors.cyan,
                        fontWeight: FontWeight.w900),
                  ),
                  const Text(
                    'unofficial',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'SulphurPoint',
                        color: Colors.cyan,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            StatefulBuilder(
              builder: (context, setLoginState) {
                Widget renderWidgetBasedOnState(loginState, updateLoginState) {
                  if (loginState['step'] == 1) {
                    return StepOne(updateLoginState: updateLoginState);
                  }

                  if (loginState['step'] == 2) {
                    return StepTwo(updateLoginState: updateLoginState, currentLoginState: loginState,);
                  }

                  if(loginState['step']==3){
                    return StepThree(updateLoginState: updateLoginState, currentLoginState: loginState);
                  }
                  return StepOne(updateLoginState: updateLoginState);
                }

                updateLoginState(Map<String, dynamic> state) {
                  setLoginState(() => loginState = state);
                }

                return renderWidgetBasedOnState(loginState, updateLoginState);
              },
            )
          ],
        ),
      ),
    );
  }
}
