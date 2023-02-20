import 'package:e_commerce/screens/login/register_page.dart';
import 'package:e_commerce/screens/product_page.dart';
import 'package:e_commerce/screens/cart/ship_to.dart';
import 'package:e_commerce/services/data.dart';
import 'package:e_commerce/services/reviews.dart';
import 'package:e_commerce/services/update_cart.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../main.dart';
import '../../widgets/fixed_title_app_bar.dart';

class Cart1 extends StatefulWidget {
  Cart1({super.key});
  final CartPageCont c = Get.put(CartPageCont());

  @override
  State<Cart1> createState() => _Cart1State();
}

class _Cart1State extends State<Cart1> {
  final String title = "titletitletitletitletitletitle title title title title";

  final MyStyles textStyle = const MyStyles();
  int number = 1;

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
  void initState() {
    super.initState();
  }

  plus(Map elem) {
    var index = cart.indexWhere((element) => element == elem);
    // cart[index].last++; //print(number);
    cart[index]['num']++;

    setState(() {});
    widget.c.update();
    updateCart();
  }

  minus(Map elem) {
    var index = cart.indexWhere((element) => element == elem);

    if (elem['num'] == 1) {
      dialogmethod(() => cart.removeAt(index));
      setState(() {});
      widget.c.update();
    } else {
      // cart[index].last--;
      cart[index]['num']--;

      //print(number);
      widget.c.update();
    }
    widget.c.update();
    setState(() {});
    updateCart();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var pageTitle = 'Your Cart';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView(
                    // physics: ClampingScrollPhysics(),
                    // shrinkWrap: true,
                    children: [
                      const SizedBox(height: 74),
                      GetBuilder<CartPageCont>(
                        builder: (_) {
                          return ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: cart.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => ProductPage(),
                                          arguments: allProducts
                                              .where((element) =>
                                                  element.id ==
                                                  (cart[index]['id']))
                                              .first);
                                    },
                                    child: cartProduct(
                                        width, plus, minus, cart[index]),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const CartTextFeild(),
                      const SizedBox(height: 16),
                      CheckOutPrice(),
                    ],
                  ),
                ),
                CustomButon(
                  text: "Check out",
                  onTap: () {
                    // addReviews();
                    print(allReviews);
                    getReviews();
                    if (cart.isNotEmpty) {
                      if (!FirebaseAuth.instance.currentUser!.isAnonymous) {
                        Get.toNamed(Shipto.id);
                      } else {
                        Get.defaultDialog(
                            title: "please complete sign in to continue",
                            titleStyle: textStyle.headingH2(neutralDark),
                            middleText: "",
                            // middleTextStyle: textStyle.bodyTextNormalRegular(co.neutralGrey),
                            buttonColor: MyColors.primaryBlue,
                            // cancelTextColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 40),
                            titlePadding: const EdgeInsets.only(
                              top: 30,
                              right: 20,
                              left: 20,
                            ),
                            actions: [
                              Container(
                                padding: const EdgeInsets.only(
                                  top: 0,
                                  bottom: 15,
                                ),
                                child: CustomButon(
                                  text: "Go back to login page",
                                  // width: 30,
                                  color: MyColors.primaryBlue,
                                  textcolor: MyColors.backgroundWhite,
                                  onTap: () {
                                    user = null;
                                    favourates = [];
                                    cart = [];
                                    orders = [];
                                    allReviews = [];
                                    Get.offAndToNamed(RegisterPage.id);
                                  },
                                  border: true,
                                ),
                              ),
                            ]);
                      }
                    } else {
                      Get.defaultDialog(
                          title: "Cart is empty",
                          titleStyle: textStyle.headingH2(neutralDark),
                          middleText: "",
                          // middleTextStyle: textStyle.bodyTextNormalRegular(co.neutralGrey),
                          buttonColor: MyColors.primaryBlue,
                          // cancelTextColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 40),
                          titlePadding: const EdgeInsets.only(top: 30),
                          actions: [
                            Container(
                              padding: const EdgeInsets.only(
                                top: 0,
                                bottom: 15,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButon(
                                    text: "Ok",
                                    width: 30,
                                    color: MyColors.primaryBlue,
                                    textcolor: MyColors.backgroundWhite,
                                    onTap: () {
                                      Get.back();
                                    },
                                    border: true,
                                  ),
                                  // SizedBox(
                                  //   width: 20,
                                  // ),
                                  // CustomButon(
                                  //   text: "No",
                                  //   width: 30,
                                  //   onTap: () => Get.back(),
                                  // ),
                                ],
                              ),
                            ),
                          ]);
                    }
                  },
                )
              ],
            ),
            FixedTitleAppBar(
              pageTitle: pageTitle,
              back2: false,
            ),
          ],
        ),
      ),
    );
  }

  Container cartProduct(double width, Function(Map element) plus,
      Function(Map element) minus, Map cartItem) {
    Product prdct =
        allProducts.where((element) => element.id == cartItem['id']).first;
    var fav = favourates.contains(cartItem['id']);
    return Container(
        height: 110,
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
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 12, right: 12, bottom: 0),
                              width: constraints.maxWidth - 24 * 2 - 32,
                              child: Text(
                                prdct.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    textStyle.headingH6(MyColors.neutralDark),
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
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  // dialogmethod(delete);
                                  dialogmethod(() => cart.removeAt(
                                      cart.indexWhere(
                                          (element) => element == cartItem)));

                                  // delete();
                                },
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: MyColors.neutralGrey,
                                ),
                              )
                            ],
                          )
                        ],
                      ),

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Text(
                                '\$${double.parse(prdct.priceAfterDiscount).toPrecision(2)}',
                                style: textStyle.headingH6(
                                  MyColors.primaryBlue,
                                )),
                          ),
                          CartNum(
                            item: cartItem,
                            plus: plus,
                            minus: minus,
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
                  );
                },
              ),
            )
          ],
        ));
  }

  void dialogmethod(Function() delete) {
    Get.defaultDialog(
        title: "Delete this product",
        titleStyle: textStyle.headingH2(neutralDark),
        middleText: "Are you shure you want to delete this product from cart",
        middleTextStyle: textStyle.bodyTextNormalRegular(MyColors.neutralGrey),
        buttonColor: MyColors.primaryBlue,
        cancelTextColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 40),
        titlePadding: const EdgeInsets.only(top: 30),
        actions: [
          Container(
            padding: const EdgeInsets.only(
              top: 0,
              bottom: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButon(
                  text: "Yes",
                  width: 30,
                  color: Colors.white,
                  textcolor: MyColors.neutralDark,
                  onTap: () {
                    Get.back();
                    delete();
                    widget.c.update();
                    updateCart();
                    setState(() {});
                  },
                  border: true,
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomButon(
                  text: "No",
                  width: 30,
                  onTap: () => Get.back(),
                ),
              ],
            ),
          ),
        ]);
  }
}

class CartNum extends StatefulWidget {
  const CartNum({
    Key? key,
    required this.item,
    this.plus,
    this.minus,
  }) : super(key: key);

  final Map item;
  final Function(Map element)? plus;
  final Function(Map element)? minus;

  @override
  State<CartNum> createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: MyColors.neutralLight,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                widget.plus != null
                    ? InkWell(
                        onTap: () => widget.plus!(widget.item),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: const Icon(
                              Icons.add,
                              size: 18,
                            )),
                      )
                    : const SizedBox(
                        width: 0.0,
                      ),
                InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: Container(
                      color: MyColors.neutralLight,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 6.5),
                      child: Text('${widget.item['num']}')),
                ),
                widget.minus != null
                    ? InkWell(
                        onTap: () => widget.minus!(widget.item),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: const Icon(Icons.remove, size: 18)),
                      )
                    : const SizedBox(
                        width: 0.0,
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CartTextFeild extends StatefulWidget {
  const CartTextFeild({super.key});

  @override
  State<CartTextFeild> createState() => _CartTextFeildState();
}

class _CartTextFeildState extends State<CartTextFeild> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  FocusNode searchFocus1 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey1,
      child: TextFormField(
        focusNode: searchFocus1,
        validator: (data) {
          if (data!.isEmpty) {
            return 'field is required';
          } else {
            return "Invalid Cupon Code";
          }
        },
        onChanged: (val) {},
        style: const MyStyles().formtextfill(MyColors.neutralGrey),
        decoration: InputDecoration(
          //suffixIconColor: FigmaColors.primaryBlue,
          suffixIcon: SizedBox(
            height: 65,
            child: CustomButon(
              text: "Apply",
              width: 87,
              borderNumb: 0,
              onTap: () {
                _formKey1.currentState!.validate();
              },
            ),
          ),

          suffixIconConstraints: const BoxConstraints(),
          hintText: "Enter Cupon Code",
          hintStyle: const MyStyles().formtextfill(MyColors.neutralLight),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: MyColors.neutralLight,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: primColor,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: MyColors.primaryRed,
            ),
          ),
          errorStyle: const MyStyles().headingH6(MyColors.primaryRed),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: MyColors.primaryRed,
            ),
          ),
        ),
      ),
    );
  }
}

class CheckOutPrice extends StatefulWidget {
  CheckOutPrice({super.key});
  final CartPageCont c = Get.put(CartPageCont());

  @override
  State<CheckOutPrice> createState() => _CheckOutPriceState();
}

class _CheckOutPriceState extends State<CheckOutPrice> {
  final MyStyles textStyle = const MyStyles();

  @override
  Widget build(BuildContext context) {
    List<double> prices = cart
        .map((e) =>
            double.parse(allProducts
                .where((element) => element.id == e['id'])
                .toList()
                .first
                .priceAfterDiscount) *
            e['num'])
        .toList();

    double totalPrice = 0.0;
    for (var item in prices) {
      totalPrice += item;
    }
    return InkWell(
        onTap: () {},
        child: GetBuilder<CartPageCont>(
            initState: (_) {},
            builder: (_) {
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.neutralLight,
                    ),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Items (${cart.isEmpty ? 0 : widget.c.sUm()})",
                              style: textStyle
                                  .bodyTextNormalRegular(MyColors.neutralGrey)),
                          Text("\$${totalPrice.toPrecision(2).toString()}",
                              style: textStyle
                                  .bodyTextNormalRegular(MyColors.neutralDark)),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Shipping",
                            style: textStyle
                                .bodyTextNormalRegular(MyColors.neutralGrey),
                          ),
                          Text(cart.isNotEmpty ? "\$40" : '\$0',
                              style: textStyle
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
                              style: textStyle
                                  .bodyTextNormalRegular(MyColors.neutralGrey)),
                          Text(cart.isNotEmpty ? "\$120" : '\$0',
                              style: textStyle
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
                          Text('Total Price',
                              style: textStyle.headingH6(MyColors.neutralDark)),
                          Text(
                              "\$${(totalPrice + (cart.isNotEmpty ? 160 : 0)).toPrecision(2).toString()}",
                              style: textStyle.headingH6(MyColors.primaryBlue)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}

class MySeparator extends StatelessWidget {
  const MySeparator(
      {Key? key, this.height = 1, this.color = MyColors.neutralLight})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}
