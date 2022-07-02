import 'package:flutter/material.dart';

class DashboardHeader extends StatefulWidget {
  DashboardHeader({Key? key, required this.preferedName, required this.profile_image}) : super(key: key);
  String preferedName;
  String profile_image;
  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  @override
  Widget build(BuildContext context) {
    var name = widget.preferedName;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: const Color(0xff029aa8)
            ),
            // child: Image.network('https://www.mybsn.com.my/mybsn/images/users/s6w4V5K4M6.jpg',fit: BoxFit.cover),
          ),
          const SizedBox(width: 24,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, $name', style: const TextStyle(fontSize: 24, fontFamily: 'Signika'),),
              const Text('Welcome back', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, fontFamily: 'Signika'),)
            ],
          )
        ],
      ),
    );
  }
}