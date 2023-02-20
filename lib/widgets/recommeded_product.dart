import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';

class RecommendedProduct extends StatelessWidget {
  const RecommendedProduct({
    Key? key,
    this.txt1,
    this.txt2,
    this.txt3,
  }) : super(key: key);
  final String? txt1;
  final String? txt2;
  final String? txt3;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      allProducts[allProducts.indexWhere(
                              (element) => element.title == "OPPOF19")]
                          .image
                          .last,
                      fit: BoxFit.fill,
                      height: width * .6,
                    )),
              ),
            ],
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 24, top: 48),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(txt1 ?? "Recomended",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          letterSpacing: .5,
                          height: 1.5,
                          fontSize: 24,
                          color: Colors.white)),
                  Text(txt2 ?? "Product",
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          letterSpacing: .5,
                          height: 1.5,
                          fontSize: 24,
                          color: Colors.white)),
                  Container(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(txt3 ?? "We recommend the best for you",
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            letterSpacing: .5,
                            height: 1.8,
                            fontSize: 12,
                            color: Colors.white)),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}
