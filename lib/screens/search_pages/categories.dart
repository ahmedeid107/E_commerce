import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';

import '../../controllers/search_page_controller.dart';
import '../../widgets/category_home.dart';
import 'package:get/get.dart';

import '../../widgets/top_fixed_search_bar.dart';

class Categories extends StatelessWidget {
  Categories({super.key});
  static String id = "/Categories";
  final IconData icon = Icons.ac_unit_rounded;
  final searchPageinputController c = Get.put(searchPageinputController());
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
    //print(MediaQuery.of(context).viewInsets.top);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: 78),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Text(
                  'Categories',
                  style: const MyStyles().headingH4(MyColors.neutralDark),
                ),
              ),
              Wrap(
                  spacing: 12,
                  runSpacing: 10,
                  children: categoriessss
                      .map(
                        (e) => CatgScrollforCategories(
                            icon: Icons.feed, catText: e),
                      )
                      .toList()),
            ],
          ),
          const TopFixedSearchBar(
            icon1: Icons.notifications_none_outlined,
            icon2: Icons.favorite_outline,
          )
        ],
      ),
    );
  }
}
