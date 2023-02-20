import 'package:e_commerce/controllers/search_page_controller.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/services/search.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/search_pages/search_page.dart';
import '../style/style.dart';

class SearchInput extends StatelessWidget {
  SearchInput({super.key, required this.onchanged});
  final searchPageController c = Get.put(searchPageController());
  final Function(String) onchanged;

  final FocusNode searchFocus = FocusNode();
  final List<String> suggestons = [
    'electronics',
    "fragrances",
    "groceries",
    "home-decoration",
    "jewelery",
    "laptops",
    "men's clothing",
    "skincare",
    "smartphones",
    "women's clothing",
  ];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Map arguemntsMap = arguements == Map ? arguements : null;
    // var index =
    //     arguemntsMap.containsKey("index") ? arguemntsMap["index"] : null;

    return WillPopScope(
      onWillPop: () async {
        if (searchFocus.hasFocus) {
          searchFocus.unfocus();
          return false;
        } else {
          return true;
        }
      },
      child: Focus(
        focusNode: searchFocus,
        child: SizedBox(
            height: 46,
            child: RawAutocomplete(
              optionsBuilder: (TextEditingValue textEditingValue) {
                List<String> matches = <String>[];
                matches.addAll(suggestons);

                matches.retainWhere((s) {
                  return s
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase());
                });
                return textEditingValue.text.isNotEmpty ? matches : [''];
              },
              onSelected: (String selection) {
                //print('You just selected $selection');
              },
              // getArgument() ? Get.arguments["search"] : ""textEditingController
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode searchFocus,
                  VoidCallback onFieldSubmitted) {
                return TextFormField(
                  autofocus: false,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Fill The Form';
                    } else if (!suggestons.contains(value)) {
                      return 'Invalid country name, please choose your country from list';
                    }
                    return null;
                  },
                  textAlignVertical: TextAlignVertical.top,
                  style: const MyStyles().formtextfill(MyColors.neutralGrey),
                  scrollPadding: const EdgeInsets.all(0),
                  // onChanged: onchanged,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: secColor,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primColor,
                        ),
                      ),
                      hintText: "Search Product",
                      hintStyle: small112400150,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: primColor,
                      )),
                  onEditingComplete: () {
                    searchFocus.unfocus();

                    Get.toNamed(SearchPage.id,
                        arguments: suggestons
                                .contains(textEditingController.text)
                            ? {
                                "Products": allProducts
                                    .where((element) =>
                                        element.category ==
                                        textEditingController.text)
                                    .toList(),
                                'search': textEditingController.text,
                                'catg': false,
                              }
                            : {
                                "Products":
                                    searchMethod(textEditingController.text)
                                            .first +
                                        searchMethod(textEditingController.text)
                                            .last,
                                'search': textEditingController.text
                              });
                    textEditingController.clear();
                  },
                  controller: textEditingController,
                  focusNode: searchFocus,
                  onFieldSubmitted: (String value) {},
                );
              },
              optionsViewBuilder: (BuildContext context,
                  void Function(String) onSelected, Iterable<String> options) {
                return options.first.isEmpty
                    ? const SizedBox(
                        height: 0.0,
                      )
                    : Material(
                        child: ListView(
                          padding: const EdgeInsets.all(0),
                          // shrinkWrap: true,
                          //    physics: ClampingScrollPhysics(),
                          children: options.map((opt) {
                            return InkWell(
                              onTap: () {
                                onSelected('');
                                Get.toNamed(SearchPage.id, arguments: {
                                  "Products": allProducts
                                      .where(
                                          (element) => element.category == opt)
                                      .toList(),
                                  'search': opt,
                                  'catg': false,
                                });
                                searchFocus.unfocus();
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 48,
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                                child: Text(
                                  opt,
                                  style: const MyStyles()
                                      .formtextnormal(MyColors.neutralGrey),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
              },
            )),
      ),
    );
  }
}
