import 'package:e_commerce/main.dart';
import 'package:e_commerce/screens/splash_offer_screen.dart';
import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/fixed_title_app_bar.dart';
import '../widgets/flash_sale_carousel.dart';
import '../widgets/recommeded_product.dart';

class OfferTapBar extends StatelessWidget {
  const OfferTapBar({super.key});

  final String title = "titletitletitletitletitletitle title title title title";
  static String id = "/offerTapBarPage";

  final MyStyles textStyle = const MyStyles();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var pageTitle = 'Offer';
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 74),
                      Container(
                        width: width - 32,
                        padding: const EdgeInsets.all(16),
                        color: MyColors.primaryBlue,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 210,
                            child: Text(
                              'Use “MEGSL” Cupon For Get 90%off',
                              style: const MyStyles().headingH4(Colors.white),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Material(
                        child: InkWell(
                          onTap: () {
                            //print("a");
                            Get.toNamed(OfferScreen.id);
                          },
                          child: Stack(children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.network(
                                        allProducts[7].image[1],
                                        fit: BoxFit.fill,
                                        height: 206,
                                      )),
                                ),
                              ],
                            ),
                            FlashSaleTItleAndTimer() //    IconButton(onPressed: myfun(), icon: Icon(Icons.abc))
                          ]),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Material(
                        child: InkWell(
                          onTap: () => Get.toNamed(OfferScreen.id),
                          child: const RecommendedProduct(
                              txt1: "90% Off Super Mega ",
                              txt2: "Sale",
                              txt3: "Special birthday Lafyuu"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FixedTitleAppBar(
              pageTitle: pageTitle,
              back2: false,
            ),
          ],
        ),
      ),
    );
  }
}
