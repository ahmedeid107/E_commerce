import 'dart:math';

import 'package:e_commerce/main.dart';

fetchdata() async {}

class Product {
  final String id;
  final String title;
  final String price;
  final String description;
  final String discountPercentage;
  final String priceAfterDiscount;

  final String category;
  final List image;
  update(r) async {
    // var h =
    var h = await db
        .collection("products")
        .where("id", isEqualTo: int.parse(id))
        .get()
        .then((value) => value.docs.first.id);
    // await db
    //     .collection("products")
    //     .where("id", isEqualTo: int.parse(id))
    //     .get()
    //     .then((value) => value.docs.remove("id"));
    await db.collection("products").doc(h).update({
      "rating": {
        "rate": rate["rate"] + r / rate["count"],
        "count": rate["count"] + 1
      }
    });
    // await db.collection("products").where("id", isEqualTo: 1).firestore;
    rate["count"] += 1;
  }

  Map<String, dynamic> rate;
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.discountPercentage,
    required this.priceAfterDiscount,
    required this.category,
    required this.image,
    required this.rate,
  });
  factory Product.fromJson(jsonData) {
    var rating = {
      'rate': jsonData['rating']['rate'] is double
          ? jsonData['rating']['rate']
          : jsonData['rating']['rate'].toDouble(),
      'count': jsonData['rating']['count']
    };
    List img = jsonData['Image'] ?? jsonData['image'];
    return Product(
        id: jsonData["id"].toString(),
        title: jsonData["title"],
        price: jsonData['price'].toString(),
        description: jsonData['description'],
        category: jsonData['category'],
        image: img,
        rate: rating,
        discountPercentage: jsonData['discountPercentage'].toString(),
        priceAfterDiscount: jsonData['priceAfterDiscount'].toString());
  }
}

var discountperc = Random().nextInt(30) + 40 + Random().nextDouble();

List<Product> productsss = [];

ftech() async {}

getDataAndPrebareProducts() async {
  List<Product> products = [];

  await db.collection("products").get().then((event) {
    for (var doc in event.docs) {
      products.add(Product.fromJson(doc.data()));
    }
  });
  return products;
}

getDataAndPrebareProducts1() async {
  List<Product> products = [];

  await db.collection("products").get().then((event) {
    for (var doc in event.docs) {
      products.add(Product.fromJson(doc.data()));
    }
  });
}
