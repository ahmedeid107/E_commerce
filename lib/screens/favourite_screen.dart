import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/favourite_controller.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final FavouriteController c = Get.put(FavouriteController());
  // List<Product> favs = [];
  @override
  // void initState() {
  //   super.initState();
  //   var h = allProducts.map((e) {
  //     if (favourates.contains(e.id)) {
  //       favs.add(e);
  //       return e;
  //     }
  //   }).toList();
  //   print(h);
  //   print(favs);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(children: [
          ListView(
            children: [
              const SizedBox(height: 62),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 14),
                child: GetBuilder<FavouriteController>(
                  init: FavouriteController(),
                  initState: (_) {},
                  builder: (_) {
                    return Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      runAlignment: WrapAlignment.spaceBetween,
                      runSpacing: 12,
                      children: c.favs
                          .map((e) => Padding(
                                padding: const EdgeInsets.only(right: 0.0),
                                child: ProductCard(
                                    prodct: e, rate: true, favourite: true),
                              ))
                          .toList(),
                    );
                  },
                ),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 6.0, top: 5),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                right: 0, left: 8, top: 3, bottom: 3),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                              color: Color(0xff9098B1),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        'Favorite Product',
                        style: title,
                      )),
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
          ),
        ]),
      ),
    );
  }
}
