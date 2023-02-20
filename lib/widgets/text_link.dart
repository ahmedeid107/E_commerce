import 'package:e_commerce/style/constants.dart';
import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  const TextLink(
      {super.key, required this.text, required this.ontap, this.fontSize = 12});
  final String text;
  final VoidCallback ontap;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Text(
        text,
        style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            color: primColor,
            height: 1.5),
      ),
    );
  }
}
