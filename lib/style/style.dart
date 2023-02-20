import 'package:flutter/material.dart';

class MyColors {
  const MyColors();

  static const Color primaryBlue = Color(0xff40bfff);
  static const Color primaryRed = Color(0xfffb7181);
  static const Color primaryYellow = Color(0xffffc833);
  static const Color primaryGreen = Color(0xff53d1b6);
  static const Color primaryPurple = Color(0xff5c61f4);
  static const Color neutralDark = Color(0xff223263);
  static const Color neutralGrey = Color(0xff9098b1);
  static const Color neutralLight = Color(0xffebf0ff);
  static const Color backgroundWhite = Color(0xffffffff);
}

class MyStyles {
  const MyStyles();

  TextStyle buttonText(color) => TextStyle(
        color: color,
        fontSize: 14,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 25.19 / 14,
        letterSpacing: 0.5,
      );

  TextStyle headingH1(color) => TextStyle(
        color: color,
        fontSize: 32,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 48 / 32,
        letterSpacing: 0.5,
      );

  TextStyle headingH2(color) => TextStyle(
        color: color,
        fontSize: 24,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 36 / 24,
        letterSpacing: 0.5,
      );

  TextStyle headingH3(color) => TextStyle(
        color: color,
        fontSize: 20,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 30 / 20,
        letterSpacing: 0.5,
      );

  TextStyle headingH4(color) => TextStyle(
        color: color,
        fontSize: 16,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
        letterSpacing: 0.5,
      );

  TextStyle headingH5(color) => TextStyle(
        color: color,
        fontSize: 14,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 21 / 14,
        letterSpacing: 0.5,
      );

  TextStyle headingH6(color) => TextStyle(
        color: color,
        fontSize: 12,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 18 / 12,
        letterSpacing: 0.5,
      );

  TextStyle bodyTextLargeBold(color) => TextStyle(
        color: color,
        fontSize: 16,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 28.79 / 16,
        letterSpacing: 0.5,
      );

  TextStyle bodyTextLargeRegular(color) => TextStyle(
        color: color,
        fontSize: 16,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 28.79 / 16,
        letterSpacing: 0.5,
      );

  TextStyle bodyTextMediumBold(color) => TextStyle(
        color: color,
        fontSize: 14,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 25.19 / 14,
        letterSpacing: 0.5,
      );

  TextStyle bodyTextMediumRegular(color) => TextStyle(
        color: color,
        fontSize: 14,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 25.19 / 14,
        letterSpacing: 0.5,
      );

  TextStyle bodyTextNormalBold(color) => TextStyle(
        color: color,
        fontSize: 12,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 21.59 / 12,
        letterSpacing: 0.5,
      );

  TextStyle bodyTextNormalRegular(color) => TextStyle(
        color: color,
        fontSize: 12,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 21.59 / 12,
        letterSpacing: 0.5,
      );

  TextStyle captionLargeBold(color) => TextStyle(
        color: color,
        fontSize: 12,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 18 / 12,
        letterSpacing: 0.5,
      );

  TextStyle captionLargeRegular(color) => TextStyle(
        color: color,
        fontSize: 12,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 18 / 12,
        letterSpacing: 0.5,
      );

  TextStyle captionnormalbold(color) => TextStyle(
        color: color,
        fontSize: 10,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 15 / 10,
        letterSpacing: 0.5,
      );

  TextStyle captionnormalregular(color) => TextStyle(
        color: color,
        fontSize: 10,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 15 / 10,
        letterSpacing: 0.5,
      );

  TextStyle captionnormalregularline(color) => TextStyle(
        color: color,
        fontSize: 10,
        decoration: TextDecoration.lineThrough,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 15 / 10,
        letterSpacing: 0.5,
      );

  TextStyle formtextnormal(color) => TextStyle(
        color: color,
        fontSize: 12,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w400,
        height: 21.59 / 12,
        letterSpacing: 0.5,
      );

  TextStyle formtextfill(color) => TextStyle(
        color: color,
        fontSize: 12,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 21.59 / 12,
        letterSpacing: 0.5,
      );

  TextStyle linkNormal(color) => TextStyle(
        color: color,
        fontSize: 14,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 21 / 14,
        letterSpacing: 0.5,
      );

  TextStyle linksmall(color) => TextStyle(
        color: color,
        fontSize: 12,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w700,
        height: 18 / 12,
        letterSpacing: 0.5,
      );
}
