import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce/screens/Account/orders_page.dart';
import 'package:e_commerce/screens/Account/profile_Page.dart';
import 'package:e_commerce/screens/login/register_page.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/widgets/button.dart';

import '../../main.dart';
import '../../widgets/fixed_title_app_bar.dart';
import 'addresses_page.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  static String id = "/AccountPage";

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final MyStyles textStyle = const MyStyles();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(
          children: [
            FirebaseAuth.instance.currentUser!.isAnonymous
                ? Center(
                    child: Text(
                      "please complete sign in to continue",
                      style: const MyStyles().headingH4(MyColors.neutralDark),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            const SizedBox(height: 74),
                            Bodyy(),
                          ],
                        ),
                      ),
                    ],
                  ),
            Positioned(
              bottom: 15,
              child: CustomButon(
                  width: width - 32,
                  text: FirebaseAuth.instance.currentUser!.isAnonymous
                      ? 'Go back to login page'
                      : "Log out",
                  onTap: () {
                    allAddresses = [];
                    user = null;
                    favourates = [];
                    cart = [];
                    orders = [];
                    allReviews = [];
                    FirebaseAuth.instance.currentUser!.isAnonymous
                        ? ''
                        : FirebaseAuth.instance.signOut();
                    Get.offAndToNamed(RegisterPage.id);
                    // user!.birthdaty = datee ?? user!.birthdaty;

                    // user!.Update();
                    // widget.cont.update();
                    // Get.back();
                  } //=> Get.toet.toNamed(Shipto.id),
                  ),
            ),
            const FixedTitleAppBar(
              pageTitle: "Account",
              back2: false,
            ),
          ],
        ),
      ),
    );
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
    return Column(children: [
      PaymentItem(
          icon: const Icon(
            Icons.person_outline,
            color: MyColors.primaryBlue,
          ),
          text: "Profile",
          widget.selected,
          0,
          ontap: () => Get.toNamed(ProfilePage.id)),
      PaymentItem(
          icon: Image.asset('assets/bag.png'),
          text: "Order",
          widget.selected,
          1,
          ontap: () => Get.toNamed(OrdersPage.id)),
      PaymentItem(
          icon: Image.asset('assets/Location.png'),
          text: "Address",
          widget.selected,
          2,
          ontap: () => Get.toNamed(AddressesPage.id)),
      // PaymentItem(
      //     icon: Icon(
      //       Icons.person_outline,
      //       color: co.primaryBlue,
      //     ),
      //     text: "Payment",
      //     widget.selected,
      //     3,
      //     ontap: () => Get.toNamed(PaymentPage.id)),
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
          //  color: Colors.white,
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
