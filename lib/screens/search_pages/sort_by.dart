import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';

import '../../controllers/search_page_controller.dart';
import '../../widgets/fixed_title_app_bar.dart';
import 'package:get/get.dart';

class SortBy extends StatefulWidget {
  SortBy({super.key});
  static String id = "/sortBy";
  final searchPageinputController c = Get.put(searchPageinputController());

  @override
  State<SortBy> createState() => _SortByState();
}

class _SortByState extends State<SortBy> {
  final IconData icon = Icons.ac_unit_rounded;
  final List<String> soortby = [
    "Best Match",
    "Time: ending soonest",
    "Time: newly listed",
    "Price + Shipping: lowest first",
    "Price + Shipping: highest first",
    "Distance: nearest first"
  ];
  @override
  Widget build(BuildContext context) {
    //print(MediaQuery.of(context).viewInsets.top);
    selected(index) {
      widget.c.sortBy = index;
      setState(() {});
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 78),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: soortby.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SortByItem(
                      ontap: () {
                        selected(index);
                        Get.back();
                      },
                      color: widget.c.sortBy == index
                          ? MyColors.primaryBlue
                          : MyColors.neutralDark,
                      sortby: soortby[index],
                    );
                  },
                ),
              ],
            ),
            const FixedTitleAppBar(pageTitle: "Category"),
          ],
        ),
      ),
    );
  }
}

class SortByItem extends StatelessWidget {
  const SortByItem({
    Key? key,
    required this.sortby,
    required this.color,
    required this.ontap,
  }) : super(key: key);
  final String sortby;
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              sortby,
              style: textStyle.bodyTextNormalBold(color),
            ),
          )
        ],
      ),
    );
  }
}
