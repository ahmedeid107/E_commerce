import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

getorders() async {
  await db
      .collection("orders")
      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((event) {
    orders = event.docs.map((e) => OrderModel.fromJson(e.data())).toList();
  }).catchError((e) {});
}
