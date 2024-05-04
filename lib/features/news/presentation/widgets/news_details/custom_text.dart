import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: Colors.black),
    );
  }
}