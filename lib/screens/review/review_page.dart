import 'package:e_commerce/controllers/review_controller.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/screens/login/register_page.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/screens/review/write_review.dart';
import 'package:e_commerce/style/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/button.dart';
import '../../widgets/review.dart';

class ReviewPage extends StatelessWidget {
  ReviewPage({super.key});
  final ReviewController c = Get.put(ReviewController());
  final MyStyles textStyle = const MyStyles();
  static String id = "/ReviewPage";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: 85),
              Padding(
                padding: const EdgeInsets.only(right: 16, left: 16),
                child: StarRate(),
              ),
              GetBuilder<ReviewController>(
                initState: (_) {},
                builder: (_) {
                  return Column(
                    children: allReviews
                        .where((element) =>
                            element.id == Get.arguments['id'] &&
                            element.rate ==
                                (c.rateNum.toDouble() == 0
                                    ? element.rate
                                    : c.rateNum.toDouble()))
                        .map<Widget>(
                          (e) => Revieww(
                            id: Get.arguments['id'],
                            userName: e.name,
                            reviewText: e.reviewText,
                            userPhoto: e.photoPath,
                            date: e.date,
                            rate: e.rate,
                          ),
                        )
                        .toList(),
                  );
                },
              ),
              const SizedBox(
                height: 70,
              )
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
                      bottom: 20, top: 5, right: 16, left: 16),
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
                        'Reviews',
                        style: title,
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Divider(
                  color: secColor,
                  thickness: 1,
                  height: 1,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 00000,
            child: Container(
              padding: const EdgeInsets.only(bottom: 15),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButon(
                    width: width - 32,
                    text: "Write Review",
                    onTap: () {
                      if (!FirebaseAuth.instance.currentUser!.isAnonymous) {
                        Get.toNamed(WrtiteReview.id,
                            arguments: {'id': Get.arguments['id']});
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

                      // print(id);
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StarRate extends StatefulWidget {
  StarRate({super.key});
  final ReviewController c = Get.put(ReviewController());

  @override
  State<StarRate> createState() => _StarRateState();
}

class _StarRateState extends State<StarRate> {
  int selected = 0;
  changeSelected(n) {
    selected = n;
    widget.c.rateNum = n;
    widget.c.update();
    setState(() {});
  }

  color(n) {
    return n == selected ? primColor : const Color(0xff9098B1);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          InkWell(
            onTap: () => changeSelected(0),
            child: Container(
              color: 0 == selected
                  ? const Color.fromRGBO(64, 191, 255, 0.1)
                  : Colors.white,
              padding: const EdgeInsets.all(16),
              child: Text(
                'All Reviews',
                style: TextStyle(
                    color: 0 == selected ? primColor : const Color(0xff9098B1),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .5,
                    height: 1.5),
              ),
            ),
          ),
          const SizedBox(width: 12),
          ReviewStars(
            rateNum: 1,
            ontap: () => changeSelected(1),
            selected: selected,
          ),
          const SizedBox(width: 12),
          ReviewStars(
            rateNum: 2,
            ontap: () => changeSelected(2),
            selected: selected,
          ),
          const SizedBox(width: 12),
          ReviewStars(
            rateNum: 3,
            ontap: () => changeSelected(3),
            selected: selected,
          ),
          const SizedBox(width: 12),
          ReviewStars(
            rateNum: 4,
            ontap: () => changeSelected(4),
            selected: selected,
          ),
          const SizedBox(width: 12),
          ReviewStars(
            rateNum: 5,
            ontap: () => changeSelected(5),
            selected: selected,
          ),
        ],
      ),
    );
  }
}

class ReviewStars extends StatelessWidget {
  const ReviewStars({
    Key? key,
    required this.rateNum,
    required this.ontap,
    required this.selected,
  }) : super(key: key);
  final VoidCallback ontap;
  final int rateNum;
  final int selected;
  color(n) {
    return n == selected ? primColor : const Color(0xff9098B1);
  }

  backGround(n) {
    return n == selected
        ? const Color.fromRGBO(64, 191, 255, 0.1)
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: backGround(rateNum),
        child: Row(
          children: [
            Text(
              "$rateNum",
              style: TextStyle(
                  color: color(rateNum),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  letterSpacing: .5,
                  height: 1.5),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.star,
              size: 17,
              color: Color(0xFFFFC833),
            )
          ],
        ),
      ),
    );
  }
}
