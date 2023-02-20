import 'package:e_commerce/screens/cart/cart.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../main.dart';
import '../../models/order_model.dart';
import '../../services/data.dart';
import '../../style/constants.dart';
import '../../widgets/fixed_title_app_bar.dart';

class OrdersDetailsPage extends StatefulWidget {
  const OrdersDetailsPage({super.key});

  @override
  State<OrdersDetailsPage> createState() => _OrdersDetailsPageState();
}

class _OrdersDetailsPageState extends State<OrdersDetailsPage> {
  favour(var prdctId) {
    if (favourates.contains(prdctId)) {
      favourates.removeWhere((element) => element == prdctId);
      db
          .collection("favourites")
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        var idd = value.docs.first.id;
        db.collection("favourites").doc(idd).update({"favourites": favourates});
      });
    } else {
      favourates.add(prdctId);
      db
          .collection("favourites")
          .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        var idd = value.docs.first.id;
        db.collection("favourites").doc(idd).update({"favourites": favourates});
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var pageTitle = 'Order Details';
    return Scaffold(
      backgroundColor: Colors.white,
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
                      const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: ShippingState(),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        Get.arguments.total().first.length == 10
                            ? "Product"
                            : "Products",
                        style: const MyStyles().headingH5(MyColors.neutralDark),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Column(
                        children: Get.arguments
                            .total()
                            .first
                            .map<Widget>((e) => Column(
                                  children: [
                                    cartProduct(width,
                                        {"id": e.first.id, "num": e.last}),
                                    const SizedBox(height: 8),
                                  ],
                                ))
                            .toList(),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Shipping Details',
                        style: const MyStyles().headingH5(MyColors.neutralDark),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      shippingDetailss(
                        order: Get.arguments,
                      ),
                      Text(
                        'Payment Details',
                        style: const MyStyles().headingH5(MyColors.neutralDark),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      PaymentDetails(
                        order: Get.arguments,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: CustomButon(
                    text: "Notify Me",
                    onTap: () => Get.back(),
                  ),
                )
              ],
            ),
            FixedTitleAppBar(pageTitle: pageTitle),
          ],
        ),
      ),
    );
  }

  Container cartProduct(double width, Map cartItem) {
    Product prdct =
        allProducts.where((element) => element.id == cartItem['id']).first;
    var fav = favourates.contains(cartItem['id']);
    return Container(
        height: 105,
        width: width - 32,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(
              color: secColor,
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(
              prdct.image.first,
              width: 72,
              height: 72,
              fit: BoxFit.fill,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                margin: const EdgeInsets.only(
                                    left: 12, right: 12, bottom: 0),
                                width: constraints.maxWidth - 24 * 2 - 32,
                                child: Text(
                                  prdct.title,
                                  maxLines: 2,
                                  style: const MyStyles()
                                      .headingH6(MyColors.neutralDark),
                                  overflow: TextOverflow.ellipsis,
                                )),
                            Row(
                              children: <Widget>[
                                fav
                                    ? InkWell(
                                        onTap: () {
                                          favour(cartItem['id']);
                                        },
                                        child: const Icon(
                                          Icons.favorite,
                                          color: MyColors.primaryRed,
                                        ))
                                    : InkWell(
                                        onTap: () {
                                          favour(cartItem['id']);
                                        },
                                        child: const Icon(
                                          Icons.favorite_outline,
                                          color: MyColors.neutralGrey,
                                        )),
                              ],
                            )
                          ],
                        ),

                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text(
                                  '\$${(double.parse(prdct.priceAfterDiscount) * cartItem['num']).toStringAsFixed(2)}',
                                  style: const MyStyles().headingH6(
                                    MyColors.primaryBlue,
                                  )),
                            ),
                            CartNum(
                              item: cartItem,
                            ),
                          ],
                        ),

                        // Row(
                        //   children: <Widget>[
                        //     Expanded(child: Text(title)),
                        //     true?  Icon(Icons.favorite,color: FigmaColors.primaryRed,): Icon(Icons.favorite_outline,color: FigmaColors.neutralGrey,),
                        //      Icon(Icons.delete_outline,color: FigmaColors.neutralGrey,)
                        //   ],
                        // )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}

class ProductCart extends StatefulWidget {
  const ProductCart({
    Key? key,
    this.width,
  }) : super(key: key);
  final width;

  @override
  State<ProductCart> createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  bool favourite = false;

  @override
  Widget build(BuildContext context) {
    favour() {
      favourite = favourite ? false : true;
      setState(() {});
    }

    return Container(
        width: widget.width - 32,
        height: 72 + 32 + 2,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(
              color: secColor,
            ),
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: <Widget>[
            Image.asset(
              "assets/1.jpg",
              width: 72,
              height: 72,
              fit: BoxFit.fill,
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 12, bottom: 12),
                                  width: constraints.maxWidth - 24 * 2 - 32,
                                  child: const Text(
                                    "dasdasdas",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                            Row(
                              children: [
                                favourite
                                    ? InkWell(
                                        onTap: () {
                                          favour();
                                          //print(firstOrder
                                          // .shippingDetails["shipping"]);
                                        },
                                        child: const Icon(
                                          Icons.favorite,
                                          color: MyColors.primaryRed,
                                        ))
                                    : InkWell(
                                        onTap: () {
                                          favour();
                                        },
                                        child: const Icon(
                                          Icons.favorite_outline,
                                          color: MyColors.neutralGrey,
                                        )),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          //    mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: Text('\$299,43',
                                      style: const MyStyles().headingH6(
                                        MyColors.primaryBlue,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Row(
                        //   children: <Widget>[
                        //     Expanded(child: Text(title)),
                        //     true?  Icon(Icons.favorite,color: FigmaColors.primaryRed,): Icon(Icons.favorite_outline,color: FigmaColors.neutralGrey,),
                        //      Icon(Icons.delete_outline,color: FigmaColors.neutralGrey,)
                        //   ],
                        // )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}

class ShippingState extends StatelessWidget {
  ShippingState({
    Key? key,
  }) : super(key: key);

  OrderModel orderdet = Get.arguments;

  Color? divider1;

  Color? divider2;

  Color? divider3;

  Color? icon1;

  Color? icon2;

  Color? icon3;

  Color? icon4;

  @override
  Widget build(BuildContext context) {
    // if (orderdet.orderStatus == "Packing") {
    //   icon1 = co.primaryBlue;
    // } else if (orderdet.orderStatus == "Shipping") {
    icon1 = MyColors.primaryBlue;
    icon2 = MyColors.primaryBlue;
    divider1 = MyColors.primaryBlue;
    // } else if (orderdet.orderStatus == "Arriving") {
    //   icon1 = co.primaryBlue;
    //   icon2 = co.primaryBlue;
    //   divider1 = co.primaryBlue;
    //   icon3 = co.primaryBlue;
    //   divider2 = co.primaryBlue;
    // } else if (orderdet.orderStatus == "Success") {
    //   icon1 = co.primaryBlue;
    //   icon2 = co.primaryBlue;
    //   divider1 = co.primaryBlue;
    //   icon3 = co.primaryBlue;
    //   divider2 = co.primaryBlue;
    //   icon4 = co.primaryBlue;
    //   divider3 = co.primaryBlue;
    // }
    return Stack(children: [
      Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              // Container(
              //     width: 200, color: Colors.red, child: Text("data")),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Divider(
                  color: divider1 ?? MyColors.neutralLight,
                  thickness: 2,
                ),
              ),
              Expanded(
                child: Divider(
                  color: divider2 ?? MyColors.neutralLight,
                  thickness: 2,
                ),
              ),
              Expanded(
                child: Divider(
                  color: divider3 ?? MyColors.neutralLight,
                  thickness: 2,
                ),
              ),
              const SizedBox(
                width: 14,
              ),

              // Divider(),
              // Divider(),
            ],
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: <Widget>[
              Stack(
                children: [
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 15,
                      height: 15,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: icon1 ?? MyColors.neutralLight,
                    size: 26,
                  ),
                ],
              ),
              Text(
                "Packing",
                style: const MyStyles()
                    .bodyTextNormalRegular(MyColors.neutralGrey),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Stack(
                children: [
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 15,
                      height: 15,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: icon2 ?? MyColors.neutralLight,
                    size: 26,
                  ),
                ],
              ),
              Text(
                "Shipping",
                style: const MyStyles()
                    .bodyTextNormalRegular(MyColors.neutralGrey),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Stack(
                children: [
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 15,
                      height: 15,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: icon3 ?? MyColors.neutralLight,
                    size: 26,
                  ),
                ],
              ),
              Text(
                "Arriving",
                style: const MyStyles()
                    .bodyTextNormalRegular(MyColors.neutralGrey),
              )
            ],
          ),
          Column(
            children: <Widget>[
              Stack(
                children: [
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 15,
                      height: 15,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.check_circle,
                    color: icon4 ?? MyColors.neutralLight,
                    size: 26,
                  ),
                ],
              ),
              Text(
                "Success",
                style: const MyStyles()
                    .bodyTextNormalRegular(MyColors.neutralGrey),
              )
            ],
          ),
        ],
      )
    ]);
  }
}

class shippingDetailss extends StatelessWidget {
  shippingDetailss({super.key, required this.order});
  OrderModel order;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Date Shipping",
                      style: const MyStyles()
                          .bodyTextNormalRegular(MyColors.neutralGrey),
                    ),
                    Text(
                        DateFormat.yMMMMd().format(DateTime
                            .now()), //firstOrder.shippingDetails["date"]),
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
                    Text("shipping",
                        style: const MyStyles()
                            .bodyTextNormalRegular(MyColors.neutralGrey)),
                    Text(
                        'POS Reggular', //firstOrder.shippingDetails["shipping"],
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
                    Text("No. Resi",
                        style: const MyStyles()
                            .bodyTextNormalRegular(MyColors.neutralGrey)),
                    Text(
                        '000192848573', //firstOrder.shippingDetails["no respi"],
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
                    Text("Address",
                        style: const MyStyles()
                            .bodyTextNormalRegular(MyColors.neutralGrey)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                            order
                                .address()
                                .streatAddress, //firstOrder.shippingDetails["address"],
                            style: const MyStyles()
                                .bodyTextNormalRegular(MyColors.neutralDark)),
                        Text(
                            '${order.address().city},', //firstOrder.shippingDetails["address"],
                            style: const MyStyles()
                                .bodyTextNormalRegular(MyColors.neutralDark)),
                        Text(
                            order
                                .address()
                                .country, //firstOrder.shippingDetails["address"],
                            style: const MyStyles()
                                .bodyTextNormalRegular(MyColors.neutralDark)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

class PaymentDetails extends StatelessWidget {
  PaymentDetails({super.key, required this.order});
  OrderModel order;
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Items (${order.total()[2]})",
                      style: const MyStyles()
                          .bodyTextNormalRegular(MyColors.neutralGrey),
                    ),
                    Text("\$${(order.total()[1]).toStringAsFixed(2)}",
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
                    Text("Shipping",
                        style: const MyStyles()
                            .bodyTextNormalRegular(MyColors.neutralGrey)),
                    Text("\$40",
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
                    Text("Import charges",
                        style: const MyStyles()
                            .bodyTextNormalRegular(MyColors.neutralGrey)),
                    Text("\$120",
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
