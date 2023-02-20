import 'package:e_commerce/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../services/adrresses_service.dart';
import '../services/orders_service.dart';
import '../services/reviews.dart';
import '../services/update_cart.dart';

class LoginController extends GetxController {
  setFavourites(uid) async {
    await db
        .collection("favourites")
        .where("id", isEqualTo: uid)
        .get()
        .then((value) {
      favourates = value.docs.first['favourites'];
    }).catchError((e) {
      favourates = [];

      db.collection("favourites").add({'id': uid, 'favourites': []});
    });
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete {
    print("any thing");

    return super.onDelete;
  }

  @override
  void dispose() {
    print("any thing");
    getReviews();
    print("any thing");
    getAddresses();
    getorders();
    setCart();
    setFavourites(FirebaseAuth.instance.currentUser!.uid);
    // TODO: implement dispose
    super.dispose();
    print("any thing");
  }
}
