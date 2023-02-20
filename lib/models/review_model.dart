import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';

class ReviewModel {
  String id;
  // String userId;
  String name;
  String photoPath;
  String reviewText;
  DateTime date;
  double rate;

  ReviewModel({
    required this.id,
    // required this.userId,
    required this.name,
    required this.photoPath,
    required this.reviewText,
    required this.date,
    required this.rate,
  });

  factory ReviewModel.fromJson(jsondata) {
    return ReviewModel(
      date: (jsondata["date"] as Timestamp).toDate(),
      id: jsondata['id'],
      rate: jsondata['rate'] is double
          ? jsondata['rate']
          : (jsondata['rate']).toDouble(),
      reviewText: jsondata['reviewText'],
      // userId: jsondata['userId'],
      name: jsondata['name'],
      photoPath: jsondata['photoPath'],
    );
  }
}
