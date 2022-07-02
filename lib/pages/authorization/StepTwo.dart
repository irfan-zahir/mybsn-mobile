import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class StepTwo extends StatelessWidget {
  const StepTwo(
      {Key? key,
      required this.updateLoginState,
      required this.currentLoginState})
      : super(key: key);
  final updateLoginState;
  final currentLoginState;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var state = Map<String, dynamic>.from(currentLoginState['data']);
    var imageSrc = "https://www.mybsn.com.my${state['imageSrc']}";
    var fp = state['__fp'];
    var sourcePage = state['_sourcePage'];
    var cookie = state['Cookie'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 100,
          height: 120,
          child: Material(
            borderRadius: BorderRadius.circular(8),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageSrc,
                  fit: BoxFit.cover,
                )),
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const Text('Is this your security image?'),
        const SizedBox(
          height: 24,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(0.3 * width), primary: Colors.cyan),
          onPressed: () async {
            var dio = Dio();
            var BASE = dotenv.get('BASE_SERVER_URL');
            try {
              var res = await dio.post('$BASE/login/image', data: {
                "Cookie": cookie,
                "__fp": fp,
                "_sourcePage": sourcePage
              });
              res.data = Map<String, dynamic>.from(res.data);
              updateLoginState({"step": 3, "data": res.data});
            } catch (e) {
              log('step2'+e.toString());
            }
          },
          child: const Text('Yes'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromWidth(0.3 * width),
            primary: Colors.redAccent,
          ),
          onPressed: () {
            updateLoginState({"step": 1, "data": null});
          },
          child: const Text('Not Me'),
        ),
      ],
    );
  }
}
