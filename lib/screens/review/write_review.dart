import 'package:e_commerce/controllers/product_page_controller.dart';
import 'package:e_commerce/controllers/review_controller.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/review_model.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/button.dart';

class WrtiteReview extends StatefulWidget {
  WrtiteReview({super.key});
  static String id = "/WrtiteReview";
  final TextEditingController reviewTextt = TextEditingController();
  final ReviewController c = Get.put(ReviewController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  State<WrtiteReview> createState() => _WrtiteReviewState();
}

class _WrtiteReviewState extends State<WrtiteReview> {
  var rating = 0.0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    changeRate(h) {
      rating = h;
      ////print(h);
      ////print(rating);

      setState(() {
        //print(rating);
      });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20, top: 15, right: 16, left: 16),
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
                      'Write Review',
                      style: title,
                    )),
                  ],
                ),
              ),
              const Divider(
                color: secColor,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 24, left: 16, right: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 10, bottom: 0, left: 0, right: 16),
                        child: const Text(
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff223263),
                                letterSpacing: .5,
                                height: 1.5),
                            'Please write Overall level of satisfaction with your shipping / Delivery Service'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          children: [
                            Ratinng(
                                rating: rating,
                                size: 24,
                                padd: 16,
                                mutable: false,
                                onUpdate: changeRate),
                            Text(
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff9098B1),
                                    letterSpacing: .5,
                                    height: 1.5),
                                "$rating/5")
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12, top: 24),
                        child: Text(
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff223263),
                                letterSpacing: .5,
                                height: 1.5),
                            "Write Your Review"),
                      ),
                      Form(
                          key: widget.formKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 160,
                                child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please Fill The Form';
                                      }
                                      return null;
                                    },
                                    controller: widget.reviewTextt,
                                    textAlignVertical: TextAlignVertical.top,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff9098B1),
                                        letterSpacing: .5,
                                        height: 1.8),
                                    maxLines: null,
                                    minLines: null,
                                    expands: true,
                                    decoration: const InputDecoration(
                                      hintText: "Write your review here",
                                      hintStyle: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xff9098B1),
                                          letterSpacing: .5,
                                          height: 1.8),
                                      contentPadding: EdgeInsets.all(16),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xffEBF0FF),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xff40BFFF),
                                        ),
                                      ),
                                    )),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            child: Container(
                width: width - 2 * 16,
                margin: const EdgeInsets.all(16),
                child: CustomButon(
                  text: "Add Review",
                  onTap: () async {
                    final ProductPageController c =
                        Get.put(ProductPageController());
                    // getReviews();
                    if (widget.formKey.currentState!.validate()) {
                      db.collection('reviews').add({
                        'rate': rating,
                        'id': Get.arguments['id'],
                        'name': '${user!.name.first} ${user!.name.last}',
                        'photoPath': user!.photoPath,
                        'reviewText': widget.reviewTextt.text,
                        'date': DateTime.now(),
                      });
                      allReviews.add(ReviewModel(
                          id: Get.arguments['id'],
                          name: '${user!.name.first} ${user!.name.last}',
                          photoPath: user!.photoPath!,
                          reviewText: widget.reviewTextt.text,
                          date: DateTime.now(),
                          rate: rating));
                      await allProducts
                          .where((element) => element.id == Get.arguments['id'])
                          .first
                          .update(rating);
                      widget.c.update();
                      c.update();
                      print(allProducts
                          .where((element) => Get.arguments['id'] == element.id)
                          .first
                          .rate);
                      Get.back();
                      Future.delayed(
                        Duration(seconds: 0),
                        () {
                          Get.snackbar(
                            "",
                            "",
                            snackPosition: SnackPosition.values[1],
                            backgroundColor: MyColors.neutralLight,
                            duration: const Duration(milliseconds: 2000),
                            titleText: Text(
                              'Review have been added Successfully',
                              textAlign: TextAlign.center,
                              style: const MyStyles()
                                  .headingH5(MyColors.neutralDark),
                            ),
                            // messageText: Text(
                            //   'please enter a valid number',
                            //   style: sty().bodyTextNormalRegular(co.neutralGrey),
                            // ),
                          );
                        },
                      );
                    }
                  },
                )),
          )
        ],
      ),
    );
  }
}
