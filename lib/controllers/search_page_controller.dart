import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:e_commerce/models/search_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class searchPageController extends GetxController {
  TextEditingController searchController = TextEditingController();
  getArgument() {
    try {
      Get.arguments["search"];
    } catch (e) {
      return false;
    }
    return true;
  }

  searchValue() {
    searchController.text = getArgument() ? Get.arguments["search"] : "";
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(Get.currentRoute);
    // searchController.text = getArgument() ? Get.arguments["search"] : "";

    print("success");
  }
}

class searchPageinputController extends GetxController {
  TextEditingController searchController = TextEditingController();

  String? catgory;
  int? catgoryIndex;
  int? sortBy;
  bool? back;
  // var formatter = NumberFormat("00");
  TextEditingController mincont = TextEditingController();
  TextEditingController maxcont = TextEditingController();
  // maxcont.text = "";
  double rangeValueMin = 0;
  double ramgeValueMax = 100000;
  RangeValues currentRangeValues(min, max) {
    return RangeValues(min, max);
  }

  final CurrencyTextInputFormatter formatter1 = CurrencyTextInputFormatter(
      decimalDigits: 0, enableNegative: false, symbol: "\$");
  final CurrencyTextInputFormatter formatter2 = CurrencyTextInputFormatter(
      decimalDigits: 0, enableNegative: false, symbol: "\$");
  SearchPtternns condition =
      SearchPtternns.fromJson(SearchPatternsUsed.condition);
  SearchPtternns buyingFormat =
      SearchPtternns.fromJson(SearchPatternsUsed.buyingFormat);
  SearchPtternns itemLocation =
      SearchPtternns.fromJson(SearchPatternsUsed.itemLocation);
  SearchPtternns showOnly =
      SearchPtternns.fromJson(SearchPatternsUsed.showOnly);

//
  getArgument() {
    if (Get.arguments != null) {
      if (Get.arguments["search"] == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  searchValue() {
    searchController.text = getArgument() ? Get.arguments["search"] : "";
  }

  @override
  void onInit() {
    // TODO: implement onInit
    mincont.text = formatter1.format("0");
    maxcont.text = formatter2.format("100000");

    super.onInit();
    print(Get.currentRoute);
    if (getArgument()) {
      searchController.text = Get.arguments["search"];
    } else {
      searchController.text = '';
    }
    // searchController.text = getArgument() ? Get.arguments["search"] : "";

    print("success");
  }
}

class Products extends GetxController {
  List productss = Get.arguments['Products'];
  List productssUnCtegorized = Get.arguments['Products'];
}
