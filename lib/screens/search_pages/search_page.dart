import 'package:e_commerce/screens/search_pages/category_search.dart';
import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/search_page_controller.dart';
import '../../widgets/product_card.dart';
import '../../widgets/search_page_input.dart';
import 'search_product_notfound.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});
  static String id = "/SearchPage";
  final searchPageinputController c = Get.put(searchPageinputController());
  final Products c1 = Get.put(Products());

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void dispose() {
    super.dispose();
    widget.c.catgory = null;
  }

  final List categoriessss = const [
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
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GetBuilder<searchPageController>(
              initState: (_) {},
              builder: (_) {
                return Stack(
                  children: [
                    widget.c1.productss.isEmpty && Get.arguments['catg'] == null
                        ? NotFound(width: width)
                        : SingleChildScrollView(
                            // padding: EdgeInsets.all(0),
                            child: GetBuilder<Products>(
                                initState: (_) {},
                                builder: (_) {
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 146,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${widget.c1.productss.length} Result',
                                            style: const MyStyles()
                                                .bodyTextMediumBold(
                                                    MyColors.neutralGrey),
                                          ),
                                          GetBuilder<searchPageinputController>(
                                              builder: (value) {
                                            return InkWell(
                                              onTap: () {
                                                Get.toNamed(CatgorySearch.id,
                                                    arguments: {
                                                      'ind':
                                                          categoriessss.indexOf(
                                                              widget.c.catgory),
                                                      'Products': [],
                                                      'catg': null
                                                    });
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    widget.c.catgory ??
                                                        "All Categories",
                                                    style: const MyStyles()
                                                        .headingH6(MyColors
                                                            .neutralDark),
                                                  ),
                                                  const Icon(
                                                    Icons.expand_more,
                                                    color: MyColors.neutralGrey,
                                                  )
                                                ],
                                              ),
                                            );
                                          }),
                                        ],
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: Wrap(
                                              runSpacing: 12,
                                              alignment:
                                                  WrapAlignment.spaceBetween,
                                              children: widget.c1.productss
                                                  .map<Widget>((e) => Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 0.0),
                                                        child: ProductCard(
                                                          prodct: e,
                                                          rate: true,
                                                        ),
                                                      ))
                                                  .toList(),
                                            )),
                                      ),
                                      // CustomButon(text: "text",onTap: print();,)
                                    ],
                                  );
                                })),
                    const TopFixedSearchBarForSearchBar(
                        icon1: Icons.sort, icon2: Icons.filter_alt),
                  ],
                );
              })),
    );
  }
}

// ignore_for