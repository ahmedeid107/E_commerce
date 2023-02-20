import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/review_model.dart';

int getNumberOfReviews(String id) {
  return allReviews.where((element) => element.id == id).toList().length;
}

double getWholeRatings(String id) {
  var number = allReviews
      .where((element) => element.id == id)
      .map((e) => e.rate)
      .toList();
  double wholerate = 0;
  number.map((e) => wholerate += e).toList();
  return number.isNotEmpty ? wholerate / number.length : 0;
}

addReviews() {
  allProducts.map((e) {
    db.collection('reviews').add({
      'rate': 5,
      'id': e.id,
      'name': 'Ahmed mohamed',
      'photoPath': user!.photoPath,
      'reviewText': 'Best product for ever',
      'date': DateTime.now(),
    });
  }).toList();
}

getReviews() {
  db.collection('reviews').get().then((value) {
    allReviews = value.docs.map((e) => ReviewModel.fromJson(e.data())).toList();
  });
}
