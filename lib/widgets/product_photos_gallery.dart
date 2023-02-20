import 'package:e_commerce/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../services/data.dart';

class ProductPhotoscarousel extends StatefulWidget {
  final Product prdct;

  const ProductPhotoscarousel({super.key, required this.prdct});
  @override
  State<ProductPhotoscarousel> createState() => _ProductPhotoscarouselState();
}

class _ProductPhotoscarouselState extends State<ProductPhotoscarousel> {
  CarouselController buttonCarouselController = CarouselController();
  List<Widget> h = [];
  @override
  void initState() {
    super.initState();

    h = widget.prdct.image
        .map(
          (e) => ImgeForCArousel(r: e),
        )
        .toList();
  }

  CalouserChange calouserLogic = CalouserChange();
  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
        CarouselSlider(
          items: h,
          carouselController: buttonCarouselController,
          options: CarouselOptions(
            enlargeCenterPage: true,
            viewportFraction: 1,
            //  aspectRatio: 2.0,
            initialPage: 0,

            onPageChanged: (index, reason) {
              calouserLogic.changeSelectedColor(index);
              setState(() {});
            },
          ),
        ),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.prdct.image
                    .map(
                      (e) => CarouselPoints(
                          color: calouserLogic.colorss[
                              "color${widget.prdct.image.indexWhere((element) => element == e)}"],
                          ontap: () async => await changPage(widget.prdct.image
                              .indexWhere((element) => element = e))),
                    )
                    .toList()
                //  [
                //   carouselPoints(
                //       color: calouserLogic.colorss["color0"],
                //       ontap: () async => await changPage(0)),
                //   carouselPoints(
                //       color: calouserLogic.colorss["color1"],
                //       ontap: () async => await changPage(1)),
                //   carouselPoints(
                //       color: calouserLogic.colorss["color2"],
                //       ontap: () async => await changPage(2)),
                //   carouselPoints(
                //       color: calouserLogic.colorss["color3"],
                //       ontap: () async => await changPage(3)),
                //   carouselPoints(
                //       color: calouserLogic.colorss["color4"],
                //       ontap: () async => await changPage(4)),
                // ],
                ),
          ),
        ),
      ]);
  changPage(int index) async {
    await buttonCarouselController.animateToPage(index);
    //print(index);
    calouserLogic.changeSelectedColor(index);
    setState(() {});
  }
}

class ImgeForCArousel extends StatelessWidget {
  const ImgeForCArousel({
    Key? key,
    required this.r,
  }) : super(key: key);

  final String r;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                r,
                fit: BoxFit.fill,
                height: width * .6,
              )))
    ]);
  }
}

class CarouselPoints extends StatelessWidget {
  const CarouselPoints({Key? key, required this.color, required this.ontap})
      : super(key: key);
  final Color? color;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ontap,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
            child: Icon(Icons.circle, color: color, size: 10)));
  }
}

class CalouserChange {
  Map<String, Color> colorss = {
    "color0": primColor,
    "color1": secColor,
    "color2": secColor,
    "color3": secColor,
    "color4": secColor,
  };
//  Color color1 = secColor;
//   Color color2 = secColor;
//   Color color3 = secColor;
//   Color color4 = secColor;
//   Color color5 = secColor;

  Color selected = primColor;
  void changeSelectedColor(int indexOfSelected) {
    colorss.forEach((key, value) {
      colorss[key] = secColor;
    });
    colorss["color$indexOfSelected"] = primColor;
  }
}
