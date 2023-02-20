import 'package:e_commerce/main.dart';
import 'package:e_commerce/screens/splash_offer_screen.dart';
import 'package:e_commerce/widgets/recommeded_product.dart';
import 'package:flutter/material.dart';
import '../controllers/home_page_controller.dart';
import '../widgets/category_home.dart';
import '../widgets/flash_sale_carousel.dart';
import '../widgets/product_card.dart';
import '../widgets/tilte_more_link.dart';
import 'package:get/get.dart';

import '../widgets/top_fixed_search_bar.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final HomePageController c = Get.put(HomePageController());

  final IconData icon = Icons.ac_unit_rounded;
  final String catText = "catText catText ";
  final List categoriessss = [
    'electronics',
    "laptops",
    "smartphones",
    "men's clothing",
    "women's clothing",
    "fragrances",
    "groceries",
    "home-decoration",
    "jewelery",
    "skincare",
  ];
  @override
  Widget build(BuildContext context) {
    //print(MediaQuery.of(context).viewInsets.top);

    var icon1 = Icons.notifications_outlined;
    var icon2 = Icons.favorite_outline;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 78),

                InkWell(
                  onTap: () {
                    Get.to(() => const OfferScreen());
                  },
                  child: Stack(children: [
                    CarouselWidget(),
                    FlashSaleTItleAndTimer() //    IconButton(onPressed: myfun(), icon: Icon(Icons.abc))
                  ]),
                ),
                TitleAndMoreLink(
                    h: "Category",
                    hh: "More Category",
                    onTap: () => c.tabController.animateTo(1)),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: categoriessss.map((e) {
                          return Row(
                            children: [
                              CatgScroll(icon: icon, catText: e),
                              const SizedBox(width: 12)
                            ],
                          );
                        }).toList()),
                  ),
                ),

                //    Category More Category
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, top: 24),
                  child: TitleAndMoreLink(
                    h: "Flash Sale",
                    hh: "See More",
                    onTap: () => Get.toNamed(OfferScreen.id),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: allProducts
                          .sublist(0, 7)
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: ProductCard(
                                  prodct: e,
                                ),
                              ))
                          .toList()
                      //  [

                      ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0, top: 24),
                  child: TitleAndMoreLink(
                    h: "Mega Sale",
                    hh: "See More",
                    onTap: () => Get.toNamed(OfferScreen.id),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: allProducts
                          .sublist(7, 12)
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: ProductCard(
                                  prodct: e,
                                ),
                              ))
                          .toList()),
                ),
                const RecommendedProduct(),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 14),
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    runAlignment: WrapAlignment.spaceBetween,
                    children: allProducts
                        .sublist(allProducts.length - 9, allProducts.length - 1)
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: ProductCard(
                                rate: true,
                                prodct: e,
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
            TopFixedSearchBar(icon1: icon1, icon2: icon2),
          ],
        ),
      ),
    );
  }
}
