import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/address.dart';
import 'package:firebase_auth/firebase_auth.dart';

getAddresses() async {
  await db
      .collection("Addresses")
      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((event) {
    allAddresses = event.docs.map((e) => Addresss1.fromJson(e.data())).toList();
  }).catchError((e) {});
}
