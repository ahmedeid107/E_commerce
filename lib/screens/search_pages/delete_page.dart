import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/widgets/button.dart';
import 'package:flutter/material.dart';

import '../../widgets/top_fixed_search_bar.dart';

class SearchProductNotFound extends StatefulWidget {
  const SearchProductNotFound({super.key});
  static String id = "/searchProductNotFound";

  @override
  State<SearchProductNotFound> createState() => _SearchProductNotFoundState();
}

class _SearchProductNotFoundState extends State<SearchProductNotFound> {
  final MyStyles textStyle = const MyStyles();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 146,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0 Result',
                      style: const MyStyles()
                          .bodyTextMediumBold(MyColors.neutralGrey),
                    ),
                    Row(
                      children: [
                        Text(
                          'Man Shoes',
                          style:
                              const MyStyles().headingH6(MyColors.neutralDark),
                        ),
                        const Icon(
                          Icons.expand_more,
                          color: MyColors.neutralGrey,
                        )
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: MyColors.primaryBlue,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: secColor)),
                                child: const Icon(Icons.close,
                                    size: 72, color: MyColors.backgroundWhite),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Product Not Found',
                                style: const MyStyles()
                                    .headingH2(MyColors.neutralDark),
                              ),
                              const SizedBox(height: 8),
                              Text('thank you for shopping using lafyuu',
                                  style: const MyStyles().bodyTextNormalRegular(
                                    MyColors.neutralDark,
                                  )),
                              Container(
                                width: width - 32,
                                padding: const EdgeInsets.all(16.0),
                                child: CustomButon(text: "Back to Home"),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const TopFixedSearchBar(icon1: Icons.sort, icon2: Icons.filter_alt),
          ],
        ),
      ),
    );
  }
}

class FirstPredictions extends StatelessWidget {
  const FirstPredictions({super.key});

  final IconData icon = Icons.ac_unit_rounded;

  @override
  Widget build(BuildContext context) {
    var icon1 = Icons.notifications_outlined;
    var icon2 = Icons.favorite_outline;
    var texxt = 'Nike Air Max 270 React ENG';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
      child: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: 68),
              SearchItem(texxt: texxt),
              SearchItem(texxt: texxt),
              SearchItem(texxt: texxt),
              SearchItem(texxt: texxt),
              SearchItem(texxt: texxt),
            ],
          ),
          TopFixedSearchBar(icon1: icon1, icon2: icon2),

          //
        ],
      ),
    );
  }
}

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
    required this.texxt,
  }) : super(key: key);

  final String texxt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$texxt ",
            style: const TextStyle(
              color: Color(0xff9098b1),
              fontSize: 12,
              letterSpacing: 0.50,
            ),
          ),
        ],
      ),
    );
  }
}
