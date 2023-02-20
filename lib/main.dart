// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/address.dart';
import 'package:e_commerce/models/review_model.dart';
import 'package:e_commerce/screens/Account/account_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:e_commerce/screens/cart/payment_page.dart';
import 'package:e_commerce/screens/cart/ship_to.dart';
import 'package:e_commerce/screens/cart/success_transfer.dart';
import 'package:e_commerce/screens/login/forget_password.dart';
import 'package:e_commerce/screens/login/login_page.dart';
import 'package:e_commerce/screens/notification/notification_page.dart';
import 'package:e_commerce/screens/product_page.dart';
import 'package:e_commerce/screens/review/review_page.dart';
import 'package:e_commerce/screens/search_pages/category_search.dart';
import 'package:e_commerce/screens/search_pages/search_filter.dart';
import 'package:e_commerce/screens/search_pages/search_page.dart';
import 'package:e_commerce/screens/search_pages/search_product_notfound.dart';
import 'package:e_commerce/screens/search_pages/sort_by.dart';
import 'package:e_commerce/screens/splash_offer_screen.dart';
import 'package:e_commerce/screens/splashd_screen.dart';
import 'package:e_commerce/services/data.dart';
import 'package:e_commerce/tab_bar_view.dart';

import 'firebase_options.dart';
import 'models/user_model.dart';
import 'screens/Account/addresses_page.dart';
import 'screens/Account/new_address_page.dart';
import 'screens/Account/orders_page.dart';
import 'screens/Account/profile_Page.dart';
import 'screens/login/register_page.dart';
import 'screens/login/reset_success.dart';
import 'screens/review/write_review.dart';
import 'style/style.dart';

List<Product> allProducts = [];
List<Addresss1> allAddresses = [];
UserModel user;
List favourates = [];
List cart = [];
List orders = [];
List<ReviewModel> allReviews = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarContrastEnforced: false,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        systemStatusBarContrastEnforced: false,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark),
  );
  // Future.delayed(
  //   ()=> "2"
  // );
  allProducts = await getDataAndPrebareProducts();
  getDataAndPrebareProducts1();
  runApp(const MyApp());
}

var db = FirebaseFirestore.instance;

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // db
    //     .collection("products")
    //     .orderBy(
    //       "id",
    //     )
    //     .get()
    //     .then((value) {
    //   int i = 0;
    //   for (var h in value.docs) {
    //     var discountperc = i < 20
    //         ? Random().nextInt(10) + 10 + Random().nextDouble()
    //         : Random().nextInt(30) + 40 + Random().nextDouble();
    //     db
    //         .collection("products")
    //         .doc(h.id)
    //         .update({"discountPercentage": (discountperc / 100)});
    //     i++;
    //   }
    // });
    //print(ReviewPage.id);

    precacheImage(const AssetImage("assets/bag.png"), context);
    precacheImage(const AssetImage("assets/Google.png"), context);
    precacheImage(const AssetImage("assets/Date.png"), context);
    precacheImage(const AssetImage("assets/Gender.png"), context);
    precacheImage(const AssetImage("assets/Location.png"), context);
    precacheImage(const AssetImage("assets/Message.png"), context);
    precacheImage(const AssetImage("assets/Password.png"), context);
    precacheImage(const AssetImage("assets/Phone.png"), context);
    precacheImage(const AssetImage("assets/singleiconWhite.png"), context);
    precacheImage(const AssetImage("assets/Transaction.png"), context);
    precacheImage(const AssetImage("assets/avatar.jpg"), context);
    precacheImage(const AssetImage("assets/Icon1.png"), context);
    precacheImage(const AssetImage("assets/Credit Card.png"), context);
    precacheImage(const AssetImage("assets/Bank.png"), context);
    precacheImage(const AssetImage("assets/Paypal.png"), context);
    precacheImage(const AssetImage("assets/singleiconWhite.png"), context);

    // var h = allProducts.map((e) async {Bank
    //   for (var imgpath in e.image) {
    //     await precacheImage(NetworkImage(imgpath), context);
    //     print("ds333a");
    //     return precacheImage(NetworkImage(imgpath), context);
    //   }
    // }).toList();
    // h;
    f() async {
      for (var h in allProducts) {
        await precacheImage(
            NetworkImage(h.image.length > 3 ? h.image[3] : h.image[0]),
            context);

        // for (var j in h.image) {
        // }
      }
    }

    f();

    // print(h);
    return GetMaterialApp(
      theme: ThemeData(splashColor: MyColors.neutralLight),
      debugShowCheckedModeBanner: false,
      // initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashFuturePage(),
        ),
        GetPage(
          name: TabBarVieww.id,
          page: () => TabBarVieww(),
        ),
        GetPage(
          name: ProductPage.id,
          page: () => ProductPage(),
        ),
        GetPage(
          name: ReviewPage.id,
          page: () => ReviewPage(),
        ),
        GetPage(
          name: ProfilePage.id,
          page: () => const ProfilePage(),
        ),
        GetPage(
          name: ForgetPassword.id,
          page: () => ForgetPassword(),
        ),
        GetPage(
          name: NewAddress.id,
          page: () => NewAddress(),
        ),
        GetPage(
          name: ResetSuccess.id,
          page: () => ResetSuccess(),
        ),
        GetPage(
          name: OrdersPage.id,
          page: () => const OrdersPage(),
        ),
        GetPage(
          name: AccountPage.id,
          page: () => const AccountPage(),
        ),
        GetPage(
          name: AddressesPage.id,
          page: () => const AddressesPage(),
        ),
        GetPage(
          name: LoginPage.id,
          page: () => LoginPage(),
        ),
        GetPage(
          name: RegisterPage.id,
          page: () => RegisterPage(),
        ),
        GetPage(
          name: OfferScreen.id,
          page: () => const OfferScreen(),
        ),
        GetPage(
          name: SearchPage.id,
          page: () => SearchPage(),
        ),
        GetPage(
          name: SearchProductNotFound.id,
          page: () => SearchProductNotFound(),
        ),
        GetPage(
          name: WrtiteReview.id,
          page: () => WrtiteReview(),
        ),
        GetPage(
          name: CatgorySearch.id,
          page: () => CatgorySearch(),
        ),
        GetPage(
          name: NotificatitonPage.id,
          page: () => const NotificatitonPage(),
        ),
        GetPage(
          name: Shipto.id,
          page: () => Shipto(),
        ),
        GetPage(
          name: PaymentPage.id,
          page: () => PaymentPage(),
        ),
        GetPage(
          name: SuccessTraansferPage.id,
          page: () => const SuccessTraansferPage(),
        ),
        GetPage(
          name: SortBy.id,
          page: () => SortBy(),
        ),
        GetPage(
          name: FilterSearch.id,
          page: () => FilterSearch(),
        ),
      ],
    );
  }
}
