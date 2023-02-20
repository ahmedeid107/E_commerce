import 'package:e_commerce/main.dart';
import 'package:get/get.dart';

class CartPageCont extends GetxController {
  var c = 0;
  var sum = 0;

  // var items = cart
  //     .map((e) => e['num'] as int)
  //     .toList()
  //     .reduce((value, element) => value + element);
  sUm() {
    return cart
        .map((e) => e['num'] as int)
        .toList()
        .reduce((value, element) => value + element);
  }
}
