// ignore_for_file: prefer_const_constructors

import 'package:e_commerce/screens/search_pages/search_page.dart';
import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../widgets/fixed_title_app_bar.dart';
import '../widgets/flash_sale_carousel.dart';
import '../widgets/product_card.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});
  static String id = "/OfferScreen";

  @override
  Widget build(BuildContext context) {
    var pageTitle = 'Super Flash Sale';
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 72),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Stack(children: [
                    CarouselWidget(),
                    FlashSaleTItleAndTimer() //    IconButton(onPressed: myfun(), icon: Icon(Icons.abc))
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 14),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: allProducts
                        .sublist(0, 8)
                        .map((e) => ProductCard(
                              rate: true,
                              prodct: e,
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            FixedTitleAppBar(
              pageTitle: pageTitle,
              icon: Icons.search,
              color: MyColors.neutralGrey,
              onTap: () => Get.toNamed(SearchPage.id),
            ),
          ],
        ),
      ),
    );
  }
}
