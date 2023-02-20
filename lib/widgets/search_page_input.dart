import 'package:e_commerce/controllers/search_page_controller.dart';
import 'package:e_commerce/screens/search_pages/sort_by.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';
import '../screens/search_pages/search_filter.dart';
import '../screens/search_pages/search_page.dart';
import '../services/search.dart';
import '../style/style.dart';

class TopFixedSearchBarForSearchBar extends StatelessWidget {
  const TopFixedSearchBarForSearchBar({
    Key? key,
    this.icon1,
    this.icon2,
  }) : super(key: key);

  final IconData? icon1;
  final IconData? icon2;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(child: SearchInputForSearchPage(onchanged: (d) {})),
                icon1 == null
                    ? const Text('')
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                            onTap: () {
                              Get.toNamed(SortBy.id);
                            },
                            child: Icon(icon1, color: const Color(0xff9098B1))),
                      ),
                icon2 == null
                    ? const Text('')
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () {
                              Get.toNamed(FilterSearch.id);
                            },
                            child: Icon(icon2, color: const Color(0xff9098B1))),
                      ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              color: secColor,
              thickness: 1,
              height: 1,
            ),
          ]),
    );
  }
}

class SearchInputForSearchPage extends StatefulWidget {
  const SearchInputForSearchPage({super.key, required this.onchanged});
  final Function(String) onchanged;

  @override
  State<SearchInputForSearchPage> createState() =>
      _SearchInputForSearchPageState();
}

class _SearchInputForSearchPageState extends State<SearchInputForSearchPage> {
  final searchPageinputController c = Get.put(searchPageinputController());
  final FocusNode searchFocus1 = FocusNode();
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
  void initState() {
    super.initState();
    {
      c.searchController.text = c.getArgument() ? Get.arguments["search"] : "";
    }
  }

  @override
  Widget build(BuildContext context) {
    // Map arguemntsMap = arguements == Map ? arguements : null;
    // var index =
    //     arguemntsMap.containsKey("index") ? arguemntsMap["index"] : null;

    return WillPopScope(
      onWillPop: () async {
        if (searchFocus1.hasFocus) {
          searchFocus1.unfocus();
          return false;
        } else {
          return true;
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 46,
            child: Focus(
              focusNode: searchFocus1,
              child: RawAutocomplete(
                initialValue: c.searchController.value,
                // focusNode: searchFocus1,
                // textEditingController: c.searchController,
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
                // getArgument() ? Get.arguments["search"] : ""
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode searchFocus,
                    VoidCallback onFieldSubmitted) {
                  // textEditingController = c.searchController;
                  // searchFocus1 = searchFocus1;

                  return TextFormField(
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
                      // Get.toNamed(SearchPage.id,
                      //     arguments: {"search": c.searchController.text});
                      c.catgory = null;

                      Get.offNamed(SearchPage.id,
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
                                  "Products": searchMethod(
                                              textEditingController.text)
                                          .first +
                                      searchMethod(textEditingController.text)
                                          .last,
                                  'search': textEditingController.text
                                },
                          preventDuplicates: false);
                    },

                    controller: textEditingController,
                    focusNode: searchFocus,
                    onFieldSubmitted: (String value) {},
                  );
                },
                optionsViewBuilder: (BuildContext context,
                    void Function(String) onSelected,
                    Iterable<String> options) {
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
                                  // Get.toNamed(SearchPage.id,
                                  //     arguments: {"search": opt});
                                  c.catgory = null;

                                  Get.offNamed(SearchPage.id,
                                      arguments: {
                                        "Products": allProducts
                                            .where((element) =>
                                                element.category == opt)
                                            .toList(),
                                        'search': opt,
                                        'catg': false,
                                      },
                                      preventDuplicates: false);
                                  searchFocus1.unfocus();
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
