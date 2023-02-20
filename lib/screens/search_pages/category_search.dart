import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';

import '../../controllers/search_page_controller.dart';
import '../../main.dart';
import '../../widgets/fixed_title_app_bar.dart';
import 'package:get/get.dart';

class CatgorySearch extends StatefulWidget {
  CatgorySearch({super.key});
  static String id = "/CatgorySearch";
  final Products c1 = Get.put(Products());

  @override
  State<CatgorySearch> createState() => _CatgorySearchState();
}

class _CatgorySearchState extends State<CatgorySearch> {
  final IconData icon = Icons.ac_unit_rounded;

  int selectedd = Get.arguments['ind'];
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
    final searchPageinputController c = Get.put(searchPageinputController());
    final Products c1 = Get.put(Products());

    changeSelected(index) {
      selectedd = index;
      setState(() {});
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 68),
                ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: categoriessss
                      .map((e) => SearchItem(
                            ontap: () {
                              changeSelected(categoriessss.indexOf(e));
                              c.catgory = e;

                              c.searchController.text.isEmpty
                                  ? c1.productss = allProducts
                                      .where((element) => element.category == e)
                                      .toList()
                                  : c1.productss = c1.productssUnCtegorized
                                      .where((element) => element.category == e)
                                      .toList();

                              c.update();
                              // c.catgory = "dasdsaasd";
                              // Get.offNamedUntil(SearchPage.id,
                              //     (route) => Get.currentRoute == SearchPage.id,
                              //     arguments: {
                              //       "Products": allProducts
                              //           .where(
                              //               (element) => element.category == e)
                              //           .toList(),
                              //       'catg': true,
                              //     });

                              c.catgory = e;
                              //       Get.toNamed(SearchPage.id, arguments: {
                              //         "Products": allProducts
                              //             .where((element) => element.category == catText)
                              //             .toList(),
                              //         'catg': true,
                              //       });

                              c.update();
                              c1.update();
                              Get.back();
                            },
                            color: selectedd == categoriessss.indexOf(e)
                                ? MyColors.primaryBlue
                                : MyColors.neutralDark,
                            cat: e,
                          ))
                      .toList(),
                ),
              ],
            ),
            const FixedTitleAppBar(pageTitle: "Category"),

            //   SearchItem(texxt: texxt),
            //   SearchItem(texxt: texxt),
            //   SearchItem(texxt: texxt),
            //   SearchItem(texxt: texxt),
            //   SearchItem(texxt: texxt),
            //
          ],
        ),
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
    required this.cat,
    required this.color,
    required this.ontap,
  }) : super(key: key);
  final String cat;
  final Color color;
  final VoidCallback ontap;

  final MyStyles textStyle = const MyStyles();

  final MyColors colors = const MyColors();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              height: 24,
            ),
          ),
          Text(
            cat,
            style: textStyle.headingH5(color),
          )
        ],
      ),
    );
  }
}
