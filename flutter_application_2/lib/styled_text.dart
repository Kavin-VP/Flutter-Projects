import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  StyledText(this.text, {super.key});
  String text;
  @override
  Widget build(context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 20.0,
          backgroundColor: Colors.black),
    );
  }
}
