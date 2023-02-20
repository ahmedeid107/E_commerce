import 'package:e_commerce/main.dart';
import 'package:get/get.dart';

import 'package:e_commerce/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../controllers/home_page_controller.dart';

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  CarouselController buttonCarouselController = CarouselController();

  List<Widget> h = [];
  // allProducts
  //     .sort((a, b) => (a.discountPercentage).compareTo(b.discountPercentage));
  // .toList()
  // .sublist(0, 4);
  // s.sort((a, b) => (a[0]).compareTo((b[0])));
  // ImgeForCArousel(r: "assets/1.jpg"),
  // ImgeForCArousel(r: "assets/2.jpg"),
  // ImgeForCArousel(r: "assets/3.jpg"),
  // ImgeForCArousel(r: "assets/4.jpg"),
  // ImgeForCArousel(r: "assets/5.jpg"),

  @override
  void initState() {
    allProducts
        .sort((b, a) => (a.discountPercentage).compareTo(b.discountPercentage));
    h = allProducts
        .sublist(7, 12)
        .map((e) => ImgeForCArousel(r: e.image[3]))
        .toList();
    super.initState();
    // List<String> assetLestForCarousel = [];
  }

  CalouserChange calouserLogic = CalouserChange();
  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            // color: Color(0xFF40BFFF),
            borderRadius: BorderRadius.circular(30),
          ),
          child: CarouselSlider(
            items: h,
            carouselController: buttonCarouselController,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              //  aspectRatio: 2.0,
              initialPage: 0,
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: (index, reason) {
                calouserLogic.changeSelectedColor(index);
                setState(() {});
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselPoints(
                  color: calouserLogic.colorss["color0"],
                  ontap: () async => await changPage(0)),
              CarouselPoints(
                  color: calouserLogic.colorss["color1"],
                  ontap: () async => await changPage(1)),
              CarouselPoints(
                  color: calouserLogic.colorss["color2"],
                  ontap: () async => await changPage(2)),
              CarouselPoints(
                  color: calouserLogic.colorss["color3"],
                  ontap: () async => await changPage(3)),
              CarouselPoints(
                  color: calouserLogic.colorss["color4"],
                  ontap: () async => await changPage(4)),
            ],
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
              borderRadius: BorderRadius.circular(5),
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

class FlashSaleTItleAndTimer extends StatelessWidget {
  FlashSaleTItleAndTimer({super.key});

  final flashtimer c = Get.put(flashtimer());

/*
  @override
  void initState() {
    timeMethod();
    Timer.periodic(const Duration(seconds: 1), (_) => timeMethod());
    super.initState();
  }

  void timeMethod() {
    var formatter = NumberFormat("00");

    // timeH = format.format(DateTime.parse("11")).toString();
    timeH = formatter.format(23 - DateTime.now().hour).toString();

    timeM = formatter.format(59 - DateTime.now().minute).toString();
    timeS = formatter.format(59 - DateTime.now().second).toString();
    setState(() {});
  }
*/
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.only(left: 24, top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Super Flash Sale",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: .5,
                    height: 1.5,
                    fontSize: 24,
                    color: Colors.white)),
            const Text("50% Off",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: .5,
                    height: 1.5,
                    fontSize: 24,
                    color: Colors.white)),
            Container(
              padding: const EdgeInsets.only(top: 29),
              child: GetBuilder<flashtimer>(builder: (value) {
                return Row(
                  children: [
                    TimeUnit(time: c.timeH!),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: const Text(
                          ":",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                    TimeUnit(time: c.timeM!),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: const Text(
                          ":",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        )),
                    TimeUnit(time: c.timeS!),
                  ],
                );
              }),
            )
          ],
        ));
  }
}

class TimeUnit extends StatelessWidget {
  const TimeUnit({
    Key? key,
    required this.time,
  }) : super(key: key);

  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // color: Color(0xFF40BFFF),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.only(top: 8, left: 9, bottom: 9, right: 11),
      child: Text(time),
    );
  }
}
