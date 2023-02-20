import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/services/update_cart.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../models/order_model.dart';
import '../../widgets/fixed_title_app_bar.dart';
import 'success_transfer.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({super.key});
  static String id = "/PaymentPage";
  final CartPageCont c = Get.find<CartPageCont>();

  @override
  State<PaymentPage> createState() => _paymentPageState();
}

class _paymentPageState extends State<PaymentPage> {
  final MyStyles textStyle = const MyStyles();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [const SizedBox(height: 74), Bodyy()],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 16),
                    CustomButon(
                      text: "Next",
                      onTap: () {
                        dialogmethod(Get.arguments);
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                )
              ],
            ),
            const FixedTitleAppBar(
              pageTitle: "Payment",
              back2: true,
            ),
          ],
        ),
      ),
    );
  }

  String paymentMethod(int num1) {
    if (num1 == 0) {
      return "Normally you will continue to add you credit or debit card information but for secruity reasons we will treat it as transfer succcess ";
    } else if (num1 == 1) {
      return "Normally you will transferred to Paypal website to complete transfer operation but for secruity reasons we will treat it as transfer succcess";
    } else {
      return "Normally you will continue transfer by your bank account but for secruity reasons we will treat it as transfer succcess";
    }
  }

  void dialogmethod(address) {
    Get.defaultDialog(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        titlePadding: const EdgeInsets.only(top: 15),
        title: "Payment",
        titleStyle: const MyStyles().headingH2(neutralDark),
        middleText: paymentMethod(0),
        middleTextStyle:
            const MyStyles().bodyTextNormalRegular(MyColors.neutralGrey),
        buttonColor: MyColors.primaryBlue,
        cancelTextColor: Colors.white,
        actions: [
          Container(
            padding: const EdgeInsets.only(
              top: 0,
              bottom: 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<CartPageCont>(
                  builder: (_) {
                    return CustomButon(
                      text: "Continue",
                      width: 100,
                      onTap: () async {
                        // print(address);
                        String userId = FirebaseAuth.instance.currentUser!.uid;
                        String id = generateRandomString(10);
                        // var f = OrderModel(
                        //     addressId: h.id,
                        //     date: DateTime.now(),
                        //     ordercart: cart,
                        //     id: id
                        //     // country: country!,
                        //     // streatAddress: streatAddress.text,
                        //     // streatAddress2: streeatAddress2.text,
                        //     // city: city.text,
                        //     // state: stateOrRegion.text,
                        //     // zibCode: zipCode.text,
                        //     // phoneNumber: phone.text,
                        //     // name: [firstName.text, lastName.text],
                        //     // userId: userId,
                        //     // id: id
                        //     );
                        // print(f.addressId);
                        // print(f.date);
                        // print(f.id);
                        // print(f.total());

                        orders.add(OrderModel(
                            addressId: address.id,
                            date: DateTime.now(),
                            ordercart: cart,
                            id: id));
                        // print(orders.last.ordercart);
                        // f = orders.last;
                        // print(f.addressId);
                        // print(f.date);
                        // print(f.id);
                        // print(f.total());
                        db.collection("orders").add({
                          'order': {
                            "addressId": address.id,
                            "date": DateTime.now(),
                            "ordercart": cart,
                          },
                          'userId': userId,
                          'id': id
                        });
                        // cart = [
                        //   {'id': '25', 'num': 1},
                        //   {'id': '10', 'num': 3},
                        // ];
                        // add new order model to orders list
                        // orders.add(OrderModel(
                        //     date: DateTime.now(),
                        //     addressId: address.id,
                        //     ordercart: cart,
                        //     id: id));

                        // var lastAdded = orders.last;
                        // print('addressId: ${lastAdded.addressId}');
                        // print('date: ${lastAdded.date}');
                        // print('id: ${lastAdded.id}');
                        // print('ordercart: ${lastAdded.ordercart}');
                        // print('totalprice: ${lastAdded.totalprice()}');

                        cart = [];

                        // print('After []');
                        // print('addressId: ${lastAdded.addressId}');
                        // print('date: ${lastAdded.date}');
                        // print('id: ${lastAdded.id}');
                        // print('ordercart: ${lastAdded.ordercart}');
                        // print('totalprice: ${lastAdded.totalprice()}');
                        await Get.offNamed(SuccessTraansferPage.id);
                        updateCart();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ]);
  }
}

class Bodyy extends StatefulWidget {
  Bodyy({super.key});
  int selected = 0;

  @override
  State<Bodyy> createState() => _BodyyState();
}

class _BodyyState extends State<Bodyy> {
  changeSelected(num1) {
    widget.selected = num1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var icon = const Icon(Icons.feed);

    return Column(children: [
      PaymentItem(
          icon: Image.asset('assets/Credit Card.png'),
          text: "Credit Card Or Debit",
          widget.selected,
          0,
          ontap: () => changeSelected(0)),
      PaymentItem(
          icon: Image.asset('assets/Paypal.png'),
          text: "Paypal",
          widget.selected,
          1,
          ontap: () => changeSelected(1)),
      PaymentItem(
          icon: Image.asset('assets/Bank.png'),
          text: "Bank Transfer",
          widget.selected,
          2,
          ontap: () => changeSelected(2)),
    ]);
  }
}

class PaymentItem extends StatelessWidget {
  const PaymentItem(
    this.index,
    this.selected, {
    Key? key,
    required this.icon,
    required this.text,
    required this.ontap,
  }) : super(key: key);

  final Widget icon;
  final String text;
  final int selected;
  final int index;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: ontap,
        child: Container(
          color: index == selected ? MyColors.neutralLight : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              icon,
              const SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: const MyStyles().headingH6(MyColors.neutralDark),
              )
            ],
          ),
        ),
      ),
    );
  }
}
