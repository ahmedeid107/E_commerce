import 'package:e_commerce/main.dart';
import 'package:e_commerce/screens/search_pages/search_page.dart';
import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search_page_controller.dart';

class CatgScrollforCategories extends StatelessWidget {
  final searchPageinputController c = Get.put(searchPageinputController());

  CatgScrollforCategories({
    Key? key,
    required this.icon,
    required this.catText,
  }) : super(key: key);

  final IconData icon;
  final String catText;
  final Map images = const {
    'electronics': 'https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg',
    "fragrances": 'https://i.dummyjson.com/data/products/14/2.jpg',
    "groceries": 'https://i.dummyjson.com/data/products/24/4.jpg',
    "home-decoration": 'https://i.dummyjson.com/data/products/26/2.jpg',
    "jewelery":
        'https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg',
    "laptops": 'https://i.dummyjson.com/data/products/7/2.jpg',
    "men's clothing":
        'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
    "skincare": 'https://i.dummyjson.com/data/products/18/thumbnail.jpg',
    "smartphones": 'https://i.dummyjson.com/data/products/5/2.jpg',
    "women's clothing":
        'https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg',
  };
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //  c.Selected(index);
        //               c.catgoryIndex = index;
        c.catgory = catText;
        Get.toNamed(SearchPage.id, arguments: {
          "Products": allProducts
              .where((element) => element.category == catText)
              .toList(),
          'catg': true,
        });
        c.update();
      },
      child: Row(
        children: <Widget>[
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Image.network(
              images[catText],
              width: 110,
              height: 110,
              fit: BoxFit.fill,
            ),
          ),
          // Container(
          //   width: 110,
          //   height: 110,
          //   decoration: BoxDecoration(
          //       color: Colors.transparent,
          //       shape: BoxShape.circle,
          //       border: Border.all(color: secColor)),
          //   child: Icon(
          //     icon,
          //     color: primColor,
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.only(left: 12),
            child: Text(catText,
                textAlign: TextAlign.center,
                style: const MyStyles().headingH5(MyColors.neutralDark)),
          )
        ],
      ),
    );
  }
}

class CatgScroll extends StatelessWidget {
  final searchPageinputController c = Get.put(searchPageinputController());

  CatgScroll({
    Key? key,
    required this.icon,
    required this.catText,
  }) : super(key: key);

  final IconData icon;
  final String catText;
  final Map images = const {
    'electronics': 'https://fakestoreapi.com/img/71kWymZ+c+L._AC_SX679_.jpg',
    "fragrances": 'https://i.dummyjson.com/data/products/14/2.jpg',
    "groceries": 'https://i.dummyjson.com/data/products/24/4.jpg',
    "home-decoration": 'https://i.dummyjson.com/data/products/26/2.jpg',
    "jewelery":
        'https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg',
    "laptops": 'https://i.dummyjson.com/data/products/7/2.jpg',
    "men's clothing":
        'https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg',
    "skincare": 'https://i.dummyjson.com/data/products/18/thumbnail.jpg',
    "smartphones": 'https://i.dummyjson.com/data/products/5/2.jpg',
    "women's clothing":
        'https://fakestoreapi.com/img/61pHAEJ4NML._AC_UX679_.jpg',
  };
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //  c.Selected(index);
        //               c.catgoryIndex = index;
        // List<Product> catProducts = [];
        // for (var h in allProducts) {
        //   if (h.category == catText) {
        //     catProducts.add(h);
        //     // print(h);
        //   }
        // }
        c.catgory = catText;
        Get.toNamed(SearchPage.id, arguments: {
          "Products": allProducts
              .where((element) => element.category == catText)
              .toList(),
          'catg': true,
        });

        // print(catProducts);
        c.update();
      },
      child: Column(
        children: <Widget>[
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Image.network(
              images[catText],
              width: 70,
              height: 70,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            // margin: EdgeInsets.only(top: 8, right: 12),
            width: 70,
            child: Text(catText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xff9098B1),
                    height: 1.5,
                    letterSpacing: .5,
                    fontWeight: FontWeight.w400)),
          )
        ],
      ),
    );
  }
}
