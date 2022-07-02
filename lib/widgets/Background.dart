import 'package:flutter/material.dart';

class BodyContainer extends StatelessWidget {
  final Widget child;
  const BodyContainer(
      {required this.child, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Place as the child widget of a scaffold
      width: double.infinity,
      height: double.infinity,
      // padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        color: Color(0xFFF7F7F7)
      ),
      child: child,
    );
  }
}