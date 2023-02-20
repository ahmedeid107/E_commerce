import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';

class CustomButon extends StatelessWidget {
  const CustomButon(
      {super.key,
      this.color,
      this.textcolor,
      this.border,
      this.width,
      this.borderNumb,
      this.onTap,
      required this.text});
  final VoidCallback? onTap;
  final String text;
  final double? width;
  final Color? textcolor;
  final Color? color;
  final bool? border;
  final double? borderNumb;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
        backgroundColor: MaterialStateProperty.all(color ?? primColor),
        shape: border == null
            ? MaterialStateProperty.all(RoundedRectangleBorder(
                side: const BorderSide(color: MyColors.primaryBlue),
                borderRadius: BorderRadius.circular(borderNumb ?? 4)))
            : MaterialStateProperty.all(RoundedRectangleBorder(
                side: const BorderSide(color: MyColors.primaryBlue),
                borderRadius: BorderRadius.circular(borderNumb ?? 4))),
      ),
      //  border: Border.all(
      //   color: FigmaColors.primaryBlue,
      // ),
      onPressed: onTap ?? () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        width: width ?? double.infinity,
        height: 50,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                //inherit: false,
                color: textcolor ?? const Color(0xFFffffff),
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: .5,
                height: 1.8),
          ),
        ),
      ),
    );
  }
}
