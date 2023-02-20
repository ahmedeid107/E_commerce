import 'package:e_commerce/main.dart';
import 'package:e_commerce/screens/product_page.dart';
import 'package:e_commerce/services/data.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/widgets/rating.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/favourite_controller.dart';
import '../controllers/home_page_controller.dart';
import '../style/constants.dart';
import 'button.dart';

class ProductCard extends StatefulWidget {
  ProductCard(
      {super.key, this.rate = false, required this.prodct, this.favourite});
  final Product prodct;
  final HomePageController c2 = Get.put(HomePageController());

  final bool rate;
  final bool? favourite;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    widthh() {
      if ((width - 32 - 16 * 0) > 120 * 1 && (width - 32 - 16 * 1) < 120 * 2) {
        return width - 32 - 32;
      } else if ((width - 32 - 16 * 1) > 120 * 2 &&
          (width - 32 - 16 * 2) < 120 * 3) {
        return ((width - 32 - 16) / 2) - 34;
      } else if ((width - 32 - 16 * 2) > 120 * 3 &&
          (width - 32 - 16 * 3) < 120 * 4) {
        return (width - 32 - 16 * 2) / 3 - 34;
      } else if ((width - 32 - 16 * 3) > 120 * 4 &&
          (width - 32 - 16 * 5) < 120 * 6) {
        return (width - 32 - 16 * 3) / 4 - 34;
      } else if ((width - 32 - 16 * 4) > 120 * 5 &&
          (width - 32 - 16 * 6) < 120 * 7) {
        return (width - 32 - 16 * 4) / 5 - 34;
      } else if ((width - 32 - 16 * 5) > 120 * 6 &&
          (width - 32 - 16 * 7) < 120 * 8) {
        return (width - 32 - 16 * 5) / 6 - 34;
      } else {
        return 80;
      }
    }

    return Stack(clipBehavior: Clip.none, children: [
      Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: secColor,
            ),
            borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          onLongPress: () {},
          onTap: () {
            Get.toNamed(ProductPage.id,
                arguments: widget.prodct, preventDuplicates: false);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Image.network(
                    widget.prodct.image.length > 3
                        ? widget.prodct.image[3]
                        : widget.prodct.image[0],
                    width: widget.rate ? widthh().toDouble() : 109,
                    height: widget.rate ? widthh().toDouble() : 109,
                    fit: BoxFit.fill),
                SizedBox(
                  width: widget.rate ? 120 : 109,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 4),
                          child: SizedBox(
                            height: 40,
                            child: Text(
                              widget.prodct.title,
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.ellipsis,
                              style: const MyStyles()
                                  .headingH6(MyColors.neutralDark),
                            ),
                          ),
                        ),
                        widget.rate
                            ? Row(
                                children: [
                                  Ratinng(
                                      rating: allProducts
                                          .where((element) =>
                                              element.id == widget.prodct.id)
                                          .first
                                          .rate['rate']),
                                ],
                              )
                            : const SizedBox(
                                height: 0.0,
                              ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 0),
                              child: Text(
                                "\$${double.parse(widget.prodct.priceAfterDiscount).toPrecision(2)}",
                                style: const MyStyles()
                                    .bodyTextNormalBold(MyColors.primaryBlue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "\$${double.parse(widget.prodct.price).toPrecision(2)}",
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: MyColors.neutralGrey,
                                decorationThickness: 1.5,
                                fontSize: 10,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                height: 15 / 10,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              "${(double.parse(widget.prodct.discountPercentage) * 100).ceil()}% Off",
                              overflow: TextOverflow.ellipsis,
                              style: const MyStyles()
                                  .captionnormalbold(MyColors.primaryRed),
                            )
                          ],
                        ),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
      Positioned(
        // ignore: sort_child_properties_last
        child: widget.favourite == null
            ? const Text('')
            : Material(
                child: FavBasket(prdct: widget.prodct),
              ),
        bottom: 12,
        right: 12,
      )
    ]);
  }

  void dialogmethod(Function() delete) {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 40),
        titlePadding: const EdgeInsets.only(top: 30),
        title: "Delete this product from favourites",
        titleStyle: const MyStyles().headingH2(neutralDark),
        middleText: "",
        // middleTextStyle: sty().bodyTextNormalRegular(co.neutralGrey),
        buttonColor: MyColors.primaryBlue,
        cancelTextColor: Colors.white,
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
                  onTap: () {
                    Get.back();
                    delete();
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomButon(
                  text: "no",
                  width: 30,
                  onTap: () {
                    Get.back();
                  },
                  border: true,
                ),
              ],
            ),
          ),
        ]);
  }
}

class FavBasket extends StatelessWidget {
  FavBasket({
    Key? key,
    required this.prdct,
  }) : super(key: key);
  final FavouriteController c = Get.put(FavouriteController());
  final Product prdct;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        dialogmethod(
          () async {
            favourates.removeWhere((element) => element == prdct.id);
            db
                .collection("favourites")
                .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .get()
                .then(
              (value) {
                var idd = value.docs.first.id;
                db
                    .collection("favourites")
                    .doc(idd)
                    .update({"favourites": favourates});
              },
            );
            c.deleteFav(prdct);
            c.getFavs();
            c.update();
          },
        );
      },

      // splashColor: co.neutralGrey,
      child: const Icon(Icons.delete_outline),
    );
  }

  void dialogmethod(Function() delete) {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 40),
        titlePadding: const EdgeInsets.only(top: 30),
        title: "Delete this product from favourites",
        titleStyle: const MyStyles().headingH2(neutralDark),
        middleText: "",
        // middleTextStyle: sty().bodyTextNormalRegular(co.neutralGrey),
        buttonColor: MyColors.primaryBlue,
        cancelTextColor: Colors.white,
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
                  onTap: () {
                    Get.back();
                    delete();
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomButon(
                  text: "no",
                  width: 30,
                  onTap: () {
                    Get.back();
                  },
                  border: true,
                ),
              ],
            ),
          ),
        ]);
  }
}

class ProductCardGridView extends StatelessWidget {
  const ProductCardGridView(
      {super.key, this.rate, required this.width, required this.prodct});
  final double? rate;
  final double width;
  final Product prodct;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: secColor,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: InkWell(
        onTap: () {
          Get.toNamed(ProductPage.id, arguments: prodct);
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                      child: Image.network(
                    prodct.image.length > 3 ? prodct.image[3] : prodct.image[0],
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                    height: width - 16 * 2,
                  )),
                ],
              ),
              SizedBox(
                height: 95,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 4),
                        child: SizedBox(
                          height: 40,
                          child: Text(
                            prodct.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                color: neutralDark,
                                height: 1.5,
                                letterSpacing: .5,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Ratinng(
                              rating: allProducts
                                  .where((element) => element.id == prodct.id)
                                  .first
                                  .rate['rate']),
                        ],
                      ),
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(bottom: 0),
                            child: Text(
                              r"$299,43",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: primColor,
                                  height: 1.5,
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: const <Widget>[
                          Text(
                            r"$534,33",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 10,
                                color: Color(0xff9098B1),
                                height: 1.5,
                                letterSpacing: .5,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "24% Off",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10,
                                color: Color(0xffFB7181),
                                height: 1.5,
                                letterSpacing: .5,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
