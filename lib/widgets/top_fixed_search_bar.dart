import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/constants.dart';
import '../screens/favourite_screen.dart';
import '../screens/notification/notification_page.dart';
import 'search_input.dart';

class TopFixedSearchBar extends StatelessWidget {
  const TopFixedSearchBar({
    Key? key,
    this.icon1,
    this.icon2,
  }) : super(key: key);

  final IconData? icon1;
  final IconData? icon2;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: SearchInput(onchanged: (d) {})),
                icon2 == null
                    ? const Text('')
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              Get.to(() => const FavouriteScreen());
                            },
                            child: Icon(icon2, color: const Color(0xff9098B1))),
                      ),
                icon1 == null
                    ? const Text('')
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Material(
                          child: InkWell(
                              onTap: () {
                                Get.toNamed(NotificatitonPage.id);
                              },
                              child: Stack(
                                children: [
                                  Icon(icon1, color: const Color(0xff9098B1)),
                                  Positioned(
                                      top: 1,
                                      right: 1,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4)),
                                        child: Container(
                                          color: MyColors.primaryRed,
                                          width: 8,
                                          height: 8,
                                        ),
                                      ))
                                ],
                              )),
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              color: secColor,
              thickness: 1,
              height: 1,
            ),
          ]),
    );
  }
}
