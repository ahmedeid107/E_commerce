// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:e_commerce/controllers/cart_controller.dart';
import 'package:e_commerce/controllers/cart_num.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/screens/cart/cart.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/screens/search_pages/categories.dart';
import 'package:e_commerce/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/home_page_controller.dart';
import 'screens/Account/account_page.dart';
import 'screens/offer_from_tabbar.dart';

class TabBarVieww extends StatefulWidget {
  TabBarVieww({super.key});
  static String id = "/TabBarVieww";
  final HomePageController c = Get.put(HomePageController());
  final CartPageCont c1 = Get.put(CartPageCont());

  // h() {
  //   tabController.index = 1;
  // }

  @override
  State<TabBarVieww> createState() => _TabBarViewwState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _TabBarViewwState extends State<TabBarVieww>
    with TickerProviderStateMixin {
  var arguements = Get.arguments;

  int? _selectedIndex;
  @override
  void initState() {
    super.initState();
    index() {
      if (arguements is Map) {
        if (arguements.containsKey("index")) {
          return arguements["index"];
        } else {
          return null;
        }
      } else {
        return null;
      }
    }

    // print("index ${index() != null ? index() : 0}");

    // var arguemntsMap = arguements == Map ? arguements : null;
    // var index =
    // arguemntsMap.containsKey("index") ? arguemntsMap["index"] : null;

    widget.c.tabController =
        TabController(length: 5, vsync: this, initialIndex: index() ?? 0);
    _selectedIndex = widget.c.tabController.index;

    widget.c.tabController.addListener(() {
      _selectedIndex = widget.c.tabController.index;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: GetBuilder<HomePageController>(
        builder: (_) {
          return Column(
            children: [
              Expanded(
                child: TabBarView(
                  //   physics: const ClampingScrollPhysics(),
                  controller: widget.c.tabController,
                  children: <Widget>[
                    HomePage(),
                    Categories(),
                    Cart1(),
                    OfferTapBar(),
                    AccountPage()
                  ],
                ),
              ),
              TabBar(
                indicatorColor: Colors.transparent,
                controller: widget.c.tabController,
                indicatorWeight: .0001,
                // indicatorSize: TabBarIndicatorSize.label,
                // indicatorWeight: 0,
                indicator: null,
                indicatorSize: null,
                tabs: <Widget>[
                  TabBarrr(
                      title: "Home",
                      icon: Icons.home_outlined,
                      index: 0,
                      selectedIndex: _selectedIndex!),
                  TabBarrr(
                      title: "Explore",
                      icon: Icons.search_outlined,
                      index: 1,
                      selectedIndex: _selectedIndex!),
                  GetBuilder<CartNumController>(
                    init: CartNumController(),
                    builder: (_) {
                      return TabBarrr(
                          title: "Cart",
                          icon: Icons.shopping_cart_outlined,
                          index: 2,
                          selectedIndex: _selectedIndex!,
                          isCart: true,
                          cartNum: 3);
                    },
                  ),
                  TabBarrr(
                      title: "Offer",
                      icon: Icons.local_offer_outlined,
                      index: 3,
                      selectedIndex: _selectedIndex!),
                  TabBarrr(
                      title: "Account",
                      icon: Icons.person_outline,
                      index: 4,
                      selectedIndex: _selectedIndex!),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class TabBarrr extends StatelessWidget {
  const TabBarrr({
    Key? key,
    required this.title,
    this.icon,
    this.isCart,
    required this.index,
    required this.selectedIndex,
    this.cartNum,
  }) : super(key: key);
  final int? cartNum;
  final String title;
  final IconData? icon;
  final int index;
  final int selectedIndex;
  final bool? isCart;
  @override
  Widget build(BuildContext context) {
    return Tab(
      iconMargin: EdgeInsets.all(0),
      icon: Container(
        padding: EdgeInsets.only(top: 16, bottom: 4),
        child: (isCart == false || isCart == null)
            ? Icon(icon,
                color: index == selectedIndex ? primColor : Color(0xff9098B1))
            : Cart(
                icon: icon,
                index: index,
                selectedIndex: selectedIndex,
                cartNum: cartNum),
      ),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            letterSpacing: .5,
            height: 1.5,
            color: index == selectedIndex ? primColor : Color(0xff9098B1)),
      ),
    );
  }
}

class Cart extends StatelessWidget {
  const Cart(
      {Key? key,
      required this.icon,
      required this.index,
      required this.selectedIndex,
      this.cartNum})
      : super(key: key);

  final IconData? icon;
  final int index;
  final int selectedIndex;
  final int? cartNum;

  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none, children: [
      Icon(
        icon,
        color: index == selectedIndex ? primColor : Color(0xff9098B1),
        size: 24,
      ),
      cart.isEmpty
          ? SizedBox(
              height: 0.0,
            )
          : Positioned(
              top: -8,
              right: -8,
              child: Container(
                color: Colors.white,
                child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffFB7181),
                      shape: BoxShape.circle,
                      //   borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    width: 18,
                    height: 18,
                    child: Center(
                        child: Text('${cart.length}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              letterSpacing: .5,
                              height: 1.5,
                            )))),
              ))
    ]);
  }
}
