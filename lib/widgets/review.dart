import 'package:e_commerce/main.dart';
import 'package:e_commerce/screens/review/review_page.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/widgets/rating.dart';
import 'package:e_commerce/widgets/tilte_more_link.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../style/constants.dart';

class Revieww extends StatelessWidget {
  const Revieww({
    Key? key,
    this.wholerating,
    this.numberOfReviewrs,
    required this.userName,
    required this.reviewText,
    required this.userPhoto,
    required this.id,
    required this.date,
    this.link,
    required this.rate,
  }) : super(key: key);

  final double? wholerating;
  final int? numberOfReviewrs;
  final String userName;
  final String reviewText;
  final String userPhoto;
  final String id;
  final double rate;
  final DateTime date;
  final String? link;

  @override
  Widget build(BuildContext context) {
    //print("linkfromreview$link $wholerating $numberOfReviewrs");

    return wholerating == null && numberOfReviewrs == null
        ? Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Stack(
                          clipBehavior: Clip.hardEdge,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 64),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(userName,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color(0xff223263),
                                                  letterSpacing: .5,
                                                  height: 1.5)),
                                          Ratinng(
                                            rating: rate,
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 18, bottom: 40),
                                      child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 10,
                                          reviewText,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff9098B1),
                                              height: 1.8,
                                              letterSpacing: .5,
                                              fontWeight: FontWeight.w400)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                    clipBehavior: Clip.hardEdge,
                                    width: 48,
                                    height: 48,
                                    decoration: const BoxDecoration(
                                        color: primColor,
                                        shape: BoxShape.circle),
                                    child: Image.network(
                                      userPhoto,
                                      fit: BoxFit.fill,
                                    ))),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              child: Text(DateFormat.yMMMEd().format(date),
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Color(0xff9098B1),
                                      height: 1.5,
                                      letterSpacing: .5,
                                      fontWeight: FontWeight.w400)),
                            ),
                            //December 10, 2016
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        : Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 10),
            child: Column(
              children: [
                TitleAndMoreLink(
                  link: link,
                  h: "Review Product",
                  hh: "See More",
                  onTap: () =>
                      Get.toNamed(ReviewPage.id, arguments: {'id': id}),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Ratinng(
                            rating: wholerating!,
                            size: 16,
                          ),
                          Text(
                            "${wholerating!.toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xff9098B1),
                                height: 1.5,
                                letterSpacing: .5,
                                fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 3),
                          Text('($numberOfReviewrs Reviews)',
                              style: const TextStyle(
                                  fontSize: 10,
                                  color: Color(0xff9098B1),
                                  height: 1.5,
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                      Column(
                          children: allReviews
                              .where((element) => element.id == id)
                              .take(3)
                              .map(
                                (e) => Padding(
                                  padding: const EdgeInsets.only(top: 19),
                                  child: Stack(
                                    clipBehavior: Clip.hardEdge,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 64),
                                            child: Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(e.name,
                                                        style: const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Color(
                                                                0xff223263),
                                                            letterSpacing: .5,
                                                            height: 1.5)),
                                                    Ratinng(
                                                      rating: e.rate,
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 18, bottom: 40),
                                                child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 10,
                                                    e.reviewText,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff9098B1),
                                                        height: 1.8,
                                                        letterSpacing: .5,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      Positioned(
                                          top: 0,
                                          left: 0,
                                          child: Container(
                                              clipBehavior: Clip.hardEdge,
                                              width: 48,
                                              height: 48,
                                              decoration: const BoxDecoration(
                                                  color: primColor,
                                                  shape: BoxShape.circle),
                                              child: Image.network(
                                                e.photoPath,
                                                fit: BoxFit.fill,
                                              ))),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: Text(
                                            DateFormat.yMMMEd().format(e.date),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Color(0xff9098B1),
                                                height: 1.5,
                                                letterSpacing: .5,
                                                fontWeight: FontWeight.w400)),
                                      ),
                                      //December 10, 2016
                                    ],
                                  ),
                                ),
                              )
                              .toList())
                    ],
                  ),
                )
              ],
            ),
          );
  }
}

class NoReviews extends StatelessWidget {
  const NoReviews({
    Key? key,
    this.link,
    required this.id,
  }) : super(key: key);
  final String id;

  final String? link;

  @override
  Widget build(BuildContext context) {
    //print("linkfromreview$link $wholerating $numberOfReviewrs");

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 10),
      child: Column(
        children: [
          TitleAndMoreLink(
            link: link,
            h: "Review Product",
            hh: "See More",
            onTap: () {
              Get.toNamed(ReviewPage.id, arguments: {'id': id});
            },
          ),
          Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        "there are no reviews yet",
                        style: const MyStyles().headingH6(MyColors.neutralGrey),
                      )
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
