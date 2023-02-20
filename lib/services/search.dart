import 'package:get/get.dart';

import '../main.dart';

searchMethod(String searchText) {
  searchText = searchText.toLowerCase();
  List titleListprdcts = [];
  List descriptionListprdcts = [];
  List<String> split = searchText.split(' ');
  split.length > 1 ? split.removeWhere((element) => element.length < 3) : '';
  split.map(
    (e) => e.removeAllWhitespace,
  );

  titleListprdcts = allProducts
      .where((element) => split
          .map((e) => !element.title.toLowerCase().contains(e))
          .toList()
          .any((element) => !element))
      .toList();
  descriptionListprdcts = allProducts
      .where((element) => split
          .map((e) => !element.description.toLowerCase().contains(e))
          .toList()
          .any((element) => !element))
      .toList();
  // List check = split.map((e) => whole.contains(e)).toList();

  return [titleListprdcts, descriptionListprdcts];
}
