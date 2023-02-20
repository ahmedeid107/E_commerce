import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Ratinng extends StatelessWidget {
  Ratinng(
      {super.key,
      this.rating = 5,
      this.size = 13,
      this.padd = 4,
      this.mutable = true,
      this.onUpdate});
  final double rating;
  final double size;
  final double padd;
  final bool mutable;
  void Function(double)? onUpdate;

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      unratedColor: const Color(0xffEBF0FF),
      initialRating: rating,
      ignoreGestures: mutable,
      onRatingUpdate: (h) {
        onUpdate!(h);
      },
      minRating: 0,
      itemSize: size,
      glow: false,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: EdgeInsets.only(right: padd),
      itemBuilder: (context, _) =>
          const Icon(Icons.star, color: Color(0xFFFFC833)),
    );
  }
}
