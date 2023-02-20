import 'package:e_commerce/main.dart';
import 'package:get/get.dart';

import '../services/data.dart';

class FavouriteController extends GetxController {
  // void onInit() async {
  //   var id = FirebaseAuth.instance.currentUser!.uid;
  //   await db
  //       .collection("favourites")
  //       .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .then((value) {
  //     favourates = value.docs.first.data()['favourites'];
  //     print(id);
  //   });
  //   // TODO: implement onInit
  //   super.onInit();
  // }
  List<Product> favs = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFavs();
  }

  void getFavs() {
    favs = [];

    allProducts.map((e) {
      if (favourates.contains(e.id)) {
        favs.add(e);
        return e;
      }
    }).toList();
  }

  // getFavourites() {}

  deleteFav(Product fav) {
    favs.removeWhere((element) => element.id == fav.id);
  }
}
