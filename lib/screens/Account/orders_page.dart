import 'package:e_commerce/main.dart';
import 'package:e_commerce/screens/cart/cart.dart';
import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/order_model.dart';
import '../../widgets/fixed_title_app_bar.dart';
import 'order_details_page.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});
  static String id = "/OrdersPage";
  @override
  Widget build(BuildContext context) {
    var pageTitle = 'Orders';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(
          children: [
            ListView(
              children: [
                const SizedBox(height: 72),
                Column(
                  children: orders
                      .map(
                        (e) => InkWell(
                            onTap: () {
                              Get.to(() => const OrdersDetailsPage(),
                                  arguments: e);
                            },
                            child: OrderCart(order: e)),
                      )
                      .toList(),
                ),
              ],
            ),
            FixedTitleAppBar(pageTitle: pageTitle),
          ],
        ),
      ),
    );
  }
}

class OrderCart extends StatelessWidget {
  const OrderCart({
    Key? key,
    required this.order,
  }) : super(key: key);
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: MyColors.neutralLight,
              ),
              borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.id,
                  style: const MyStyles().headingH5(MyColors.neutralDark),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        "Order at Lafyuu :  ${DateFormat.yMMMEd().format(order.date)}",
                        style: const MyStyles()
                            .bodyTextNormalRegular(MyColors.neutralGrey)),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const MySeparator(),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Order Status",
                      style: const MyStyles()
                          .bodyTextNormalRegular(MyColors.neutralGrey),
                    ),
                    Text('Shipping',
                        style: const MyStyles()
                            .bodyTextNormalRegular(MyColors.neutralDark)),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Items",
                        style: const MyStyles()
                            .bodyTextNormalRegular(MyColors.neutralGrey)),
                    Text("${order.total().last} items purchased",
                        style: const MyStyles()
                            .bodyTextNormalRegular(MyColors.neutralDark)),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                const MySeparator(),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Price",
                        style: const MyStyles()
                            .bodyTextNormalRegular(MyColors.neutralGrey)),
                    Text(
                        "\$${(order.total()[1] + 40 + 120).toStringAsFixed(2)}",
                        style:
                            const MyStyles().headingH6(MyColors.primaryBlue)),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
