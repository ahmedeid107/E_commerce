import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/cart_num.dart';
import '../main.dart';

updateCart() async {
  final CartNumController f1 = Get.put(CartNumController());

  await db
      .collection("cart")
      .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) {
    var idd = value.docs.first.id;
    db.collection("cart").doc(idd).update({"cart": cart});
  });
  f1.update();
}

setCart() async {
  await db
      .collection("cart")
      .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) {
    cart = value.docs.first['cart'];
  }).catchError((e) {
    if (e.message == 'No element') {
      db
          .collection("cart")
          .add({'id': FirebaseAuth.instance.currentUser!.uid, 'cart': cart});
      cart = [];
    }
  });
}
