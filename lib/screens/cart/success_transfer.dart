import 'package:e_commerce/controllers/home_page_controller.dart';
import 'package:e_commerce/screens/Account/orders_page.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/tab_bar_view.dart';
import 'package:e_commerce/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessTraansferPage extends StatefulWidget {
  const SuccessTraansferPage({super.key});
  static String id = "/SuccessTraansferPage";

  @override
  State<SuccessTraansferPage> createState() => _SuccessTraansferPageState();
}

class _SuccessTraansferPageState extends State<SuccessTraansferPage> {
  final MyStyles textStyle = const MyStyles();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Icon(Icons.check_circle,
                      size: 72, color: MyColors.primaryBlue),
                  const SizedBox(height: 16),
                  Text(
                    'Success',
                    style: const MyStyles().headingH2(MyColors.neutralDark),
                  ),
                  const SizedBox(height: 8),
                  Text('thank you for shopping using lafyuu',
                      style: const MyStyles().bodyTextNormalRegular(
                        MyColors.neutralDark,
                      )),
                  GetBuilder<HomePageController>(
                    initState: (_) {},
                    builder: (_) {
                      var cont = Get.find<HomePageController>();
                      return Container(
                        width: width - 32,
                        padding: const EdgeInsets.all(16.0),
                        child: CustomButon(
                          text: "Back to Order",
                          onTap: () {
                            Get.offNamedUntil(
                              OrdersPage.id,
                              ModalRoute.withName(
                                TabBarVieww.id,
                              ),
                            );
                            cont.tabController.index = 4;
                            cont.update();
                            // Get.toNamed(OrdersPage.id);
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
