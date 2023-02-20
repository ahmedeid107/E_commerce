import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/address.dart';

String generateRandomString(int len) {
  var r = Random();
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => chars[r.nextInt(chars.length)]).join();
}

class OrderModel {
  String id;
  DateTime date;
  int addressId;
  List ordercart;
  total() {
    double totalpric = 0.0;
    var totalsum = 0;
    List cartPrdcts = ordercart.map((e) {
      totalsum += e["num"] as int;
      var h = allProducts.where((element) => element.id == e['id']).first;
      totalpric += (double.parse(h.price) * e["num"]);
      return [h, e["num"]];
    }).toList();
    return [cartPrdcts, totalpric, totalsum];
  }

  Addresss1 address() {
    return allAddresses.where((element) => element.id == addressId).first;
  }

  OrderModel({
    required this.date,
    required this.id,
    required this.addressId,
    required this.ordercart,
  });

  factory OrderModel.fromJson(jsondata) {
    var mapp = jsondata['order'];
    return OrderModel(
      date: (mapp["date"] as Timestamp).toDate(),
      addressId: mapp['addressId'],
      ordercart: mapp['ordercart'],
      id: jsondata['id'],
    );
  }
}

Map sampleOrder = {
  "id": "khdaskhdfds",
  "price": "\$289",
  "orderStatus": "Shipping",
  "date": DateTime.now(),
  "Products": ["jkfsdklf", "khsdfsdf", "sdkfhsdkhidsh"],
  "shippingDetails": {
    "date": DateTime.now(),
    "shipping": "POS Regular",
    "no respi": "9824723",
    "address": "dsailhf fdlsfjl fjds"
  },
  "paymentDetails": {
    "items": 4,
    "itemsPrice": 783.0,
    "shipping": 40,
    "import": 34
  },
};
