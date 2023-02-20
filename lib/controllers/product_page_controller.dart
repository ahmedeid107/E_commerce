import 'package:e_commerce/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProductPageController extends GetxController {
  List? favs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    favs = await db
        .collection("favourites")
        .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => value.docs.first['favourites']);
  }
}
