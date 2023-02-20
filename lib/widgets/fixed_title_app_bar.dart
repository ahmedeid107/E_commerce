import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/constants.dart';

class FixedTitleAppBar extends StatelessWidget {
  const FixedTitleAppBar({
    Key? key,
    required this.pageTitle,
    this.back2 = true,
    this.icon,
    this.icon1,
    this.color,
    this.color1,
    this.onTap,
  }) : super(key: key);
  final bool back2;
  final IconData? icon;
  final IconData? icon1;
  final Color? color;
  final Color? color1;
  final VoidCallback? onTap;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 15),
            child: Row(
              children: [
                back2
                    ? Padding(
                        padding: const EdgeInsets.only(right: 6.0, top: 5),
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  right: 0, left: 8, top: 3, bottom: 3),
                              child: Icon(
                                icon1 ?? Icons.arrow_back_ios,
                                size: 18,
                                color: const Color(0xff9098B1),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Text(""),
                Expanded(
                    child: Text(
                  pageTitle,
                  style: title,
                )),
                icon == null
                    ? const Text('')
                    : Material(
                        child: InkWell(
                          onTap: onTap ?? () {},
                          child: Icon(
                            icon,
                            color: color ?? MyColors.primaryBlue,
                          ),
                        ),
                      )
              ],
            ),
          ),
          const Divider(
            color: secColor,
            thickness: 1,
            height: 1,
          ),
        ],
      ),
    );
  }
}
