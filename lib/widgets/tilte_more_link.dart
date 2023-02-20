import 'package:flutter/material.dart';

import '../style/constants.dart';

class TitleAndMoreLink extends StatelessWidget {
  const TitleAndMoreLink({
    Key? key,
    required this.h,
    this.hh,
    this.link,
    this.onTap,
  }) : super(key: key);

  final String h;
  final String? hh;
  final String? link;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    //print("linkfromrlink$link");

    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            h,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: neutralDark,
                letterSpacing: .5,
                height: 1.5),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Text(
            hh == null ? "" : "$hh",
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: primColor,
                letterSpacing: .5,
                height: 1.5),
          ),
        )
      ],
    );
  }
}
