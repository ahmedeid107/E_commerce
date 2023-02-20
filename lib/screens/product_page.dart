import 'package:e_commerce/screens/search_pages/search_page.dart';
import 'package:e_commerce/services/data.dart';
import 'package:e_commerce/services/update_cart.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/screens/review/review_page.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/tab_bar_view.dart';
import 'package:e_commerce/widgets/rating.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';
import '../controllers/product_page_controller.dart';
import '../main.dart';
import '../widgets/button.dart';
import '../widgets/product_card.dart';
import '../widgets/product_photos_gallery.dart';
import '../widgets/review.dart';

class ProductPage extends StatefulWidget {
  ProductPage({super.key});
  static String id = "/ProductPage";
  final ProductPageController c = Get.put(ProductPageController());
  final CartPageCont fav = Get.put(CartPageCont());

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool favourite = false;
  Product prdct = Get.arguments;
  @override
  void initState() {
    super.initState();
    if (favourates.contains(prdct.id)) {
      favourite = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    //     physics: const ClampingScrollPhysics(),
//

    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: 60),

              ProductPhotoscarousel(prdct: prdct),
              ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: (width - 16 * 2) * .8,
                            child: Text(prdct.title,
                                style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: neutralDark,
                                    letterSpacing: .5,
                                    height: 1.5)),
                          ),
                        ],
                      ),
                      Positioned(
                          top: 3,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              if (favourite) {
                                favourates.removeWhere(
                                    (element) => element == prdct.id);
                                db
                                    .collection("favourites")
                                    .where("id",
                                        isEqualTo: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .get()
                                    .then((value) {
                                  db
                                      .collection("favourites")
                                      .doc(value.docs.first.id)
                                      .update({"favourites": favourates});
                                });
                              } else {
                                favourates.add(prdct.id);
                                db
                                    .collection("favourites")
                                    .where("id",
                                        isEqualTo: FirebaseAuth
                                            .instance.currentUser!.uid)
                                    .get()
                                    .then((value) {
                                  db
                                      .collection("favourites")
                                      .doc(value.docs.first.id)
                                      .update({"favourites": favourates});
                                });
                              }
                              favourite = !favourite;
                              widget.fav.update();
                              setState(() {});
                            },
                            child: Icon(
                              favourite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: favourite
                                  ? MyColors.primaryRed
                                  : MyColors.neutralGrey,
                            ),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 12),
                    child: Ratinng(
                      rating: allProducts
                          .where((element) => element.id == prdct.id)
                          .first
                          .rate['rate'],
                    ),
                  ),
                  Text(
                    "\$${double.parse(prdct.priceAfterDiscount).toPrecision(2)}",
                    style: const MyStyles().headingH3(MyColors.primaryBlue),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        "\$${double.parse(prdct.price).toPrecision(2)}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: MyColors.neutralGrey,
                          decorationThickness: 1.5,
                          fontSize: 16,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          height: 15 / 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "${(double.parse(prdct.discountPercentage) * 100).ceil()}% Off",
                        overflow: TextOverflow.ellipsis,
                        style: const MyStyles()
                            .bodyTextLargeBold(MyColors.primaryRed),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Description:",
                    style: const MyStyles()
                        .bodyTextNormalRegular(MyColors.neutralDark),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    prdct.description,
                    style: const MyStyles()
                        .bodyTextNormalRegular(MyColors.neutralGrey),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
              //  const SizedBox(height: 8),
              // ColorOrSizeIfGiven(
              //   listSizes: [5, 5, 7, 9, 12, 4, 76],
              // // ),
              // ColorOrSizeIfGiven(
              //   listColors: [
              //     Color(0xff9098B1),
              //     primColor,
              //     secColor,
              //     Color.fromARGB(255, 73, 112, 91),
              //     Color(0xff9098B1)
              //   ],
              // ),
              GetBuilder<ProductPageController>(
                initState: (_) {},
                builder: (_) {
                  var ratee = allProducts
                      .where((element) => prdct.id == element.id)
                      .first
                      .rate;
                  return Column(
                    children: [
                      allReviews
                              .where((element) => element.id == prdct.id)
                              .isNotEmpty
                          ? Revieww(
                              wholerating: ratee['rate'],
                              numberOfReviewrs: ratee['count'],
                              userName: allReviews
                                  .where((element) => element.id == prdct.id)
                                  .first
                                  .name,
                              reviewText: allReviews
                                  .where((element) => element.id == prdct.id)
                                  .first
                                  .reviewText,
                              userPhoto: allReviews
                                  .where((element) => element.id == prdct.id)
                                  .first
                                  .photoPath,
                              date: allReviews
                                  .where((element) => element.id == prdct.id)
                                  .first
                                  .date,
                              link: ReviewPage.id,
                              id: prdct.id,
                              rate: allReviews
                                  .where((element) => element.id == prdct.id)
                                  .first
                                  .rate,
                            )
                          : NoReviews(
                              id: prdct.id,
                            ),
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text('You Might Also Like',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: neutralDark,
                              letterSpacing: .5,
                              height: 1.5)),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: allProducts
                              .sublist(0, 7)
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: ProductCard(
                                      prodct: e,
                                    ),
                                  ))
                              .toList()

                          //  [
                          //   Padding(
                          //     padding: const EdgeInsets.only(right: 16),
                          //     child: ProductCard(rate: 3),
                          //   ),
                          //   Padding(
                          //     padding: const EdgeInsets.only(right: 16),
                          //     child: ProductCard(rate: 3),
                          //   ),
                          //   Padding(
                          //     padding: const EdgeInsets.only(right: 16),
                          //     child: ProductCard(rate: 3),
                          //   ),
                          //   Padding(
                          //     padding: const EdgeInsets.only(right: 16),
                          //     child: ProductCard(rate: 3),
                          //   ),
                          // ],
                          ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 21, left: 16, right: 16, bottom: 20),
                child: CustomButon(
                    text: "Add To Cart",
                    onTap: () {
                      // db.collection('products').get().then((value) {
                      //   for (var val in value.docs) {
                      //     db.collection('products').doc(val.id).update({
                      //       'priceAfterDiscount': (val.data()['price'] *
                      //           (1 - val.data()['discountPercentage']))
                      //     });
                      //   }
                      // });
                      Get.until((route) => Get.currentRoute == TabBarVieww.id);

                      Get.snackbar(
                        "",
                        "",
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: MyColors.neutralLight,
                        duration: const Duration(milliseconds: 1200),
                        titleText: Text(
                          'Product Added to Cart',
                          textAlign: TextAlign.center,
                          style:
                              const MyStyles().headingH5(MyColors.neutralDark),
                        ),
                        // messageText: Text(
                        //   'please enter a valid number',
                        //   style: sty().bodyTextNormalRegular(co.neutralGrey),
                        // ),
                      );
                      int index = cart.indexWhere(
                          (element) => element.values.first == prdct.id);

                      if (index == -1) {
                        cart.add({"id": prdct.id, 'num': 1});
                      } else {
                        cart[index][cart[index].keys.last]++;
                      }
                      widget.fav.update();
                      updateCart();
                    }),
              ),
            ],
          ),
          Container(
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 25, top: 5, right: 16, left: 16),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 6.0, top: 5),
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                                right: 0, left: 8, top: 3, bottom: 3),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                              color: Color(0xff9098B1),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          child: Text(
                        prdct.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: title,
                      )),
                      Material(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(SearchPage.id);
                            },
                            child: const Icon(Icons.search_outlined,
                                color: Color(0xff9098B1)),
                          ),
                        ),
                      ),
                      Material(
                        child: InkWell(
                          onTap: () => Get.toNamed(TabBarVieww.id,
                              arguments: {"index": 2}),
                          child: Cart(
                            icon: Icons.shopping_cart,
                            index: 1,
                            selectedIndex: 2,
                            cartNum: 2,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: secColor,
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ColorOrSizeIfGiven extends StatelessWidget {
  const ColorOrSizeIfGiven({
    Key? key,
    this.listSizes,
    this.listColors,
  }) : super(key: key);
  final List<double>? listSizes;
  final List<Color>? listColors;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12, top: 24, left: 16),
          child: Text(
            listSizes == null ? "Select Color" : "Select Size",
            style: const TextStyle(
                fontSize: 14,
                color: Color(0xff223263),
                height: 1.5,
                letterSpacing: .5,
                fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          height: 48,
          padding: const EdgeInsets.only(right: 16),
          child: SizeOrColorChoose(
            listSizes: listSizes,
            listColors: listColors,
          ),
        )
      ],
    );
  }
}

class SizeOrColorChoose extends StatefulWidget {
  SizeOrColorChoose({super.key, this.listSizes, this.listColors});
  final List<double>? listSizes;
  final List<Color>? listColors;
  int? selectedIndex;
  @override
  @override
  State<SizeOrColorChoose> createState() => _SizeOrColorChooseState();
}

class _SizeOrColorChooseState extends State<SizeOrColorChoose> {
  @override
  void initState() {
    super.initState();
    widget.selectedIndex = widget.listSizes == null
        ? init(widget.listColors)
        : init(widget.listSizes);

    //  (((widget.listColors!.length / 2).ceil()) > 4
    //     ? 4
    //     : (widget.listColors!.length / 2).ceil())
    // : (((widget.listSizes!.length / 2).ceil()) > 4
    //     ? 4
    //     : (widget.listSizes!.length / 2).ceil());
  }

  init(s) {
    //return (num!.length / 2).ceil() > 4 ? (num!.length / 2).ceil() : 4;

    if (((s!.length / 2).ceil()) < 3) {
      return (s!.length / 2).ceil();
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: widget.listSizes == null
          ? widget.listColors!.length
          : widget.listSizes!.length,
      itemBuilder: (BuildContext context, int index) {
        return widget.listSizes == null
            ? Padding(
                padding: const EdgeInsets.only(left: 16),
                child: InkWell(
                  onTap: () {
                    widget.selectedIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    // margin: EdgeInsets.only(left: 16),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        //color: primColor,
                        shape: BoxShape.circle,
                        color: widget.listColors![index]),
                    child: index == widget.selectedIndex
                        ? Center(
                            child: Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                                //color: primColor,
                                shape: BoxShape.circle,
                                color: Colors.white),
                          ))
                        : const Text(''),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 16),
                child: InkWell(
                  onTap: () {
                    widget.selectedIndex = index;
                    setState(() {});
                  },
                  child: Container(
                    // margin: EdgeInsets.only(left: 16),
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        //color: primColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: index == widget.selectedIndex
                                ? primColor
                                : const Color(0xffEBF0FF))),
                    child: Center(
                      child: Text(
                        widget.listSizes![index].toString(),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff223263),
                            height: 1.5,
                            letterSpacing: .5,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
