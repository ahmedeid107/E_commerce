import 'package:e_commerce/screens/login/login_page.dart';
import 'package:e_commerce/services/auth.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import '../style/style.dart';
import '../tab_bar_view.dart';

class SplashFuturePage extends StatefulWidget {
  const SplashFuturePage({Key? key}) : super(key: key);

  @override
  _SplashFuturePageState createState() => _SplashFuturePageState();
}

class _SplashFuturePageState extends State<SplashFuturePage> {
  Future<Widget> futureCall() async {
    // do async operation ( api call, auto login)
    return Future.value(auth(7) ? LoginPage() : TabBarVieww());
  }

  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
    // var height = MediaQuery.of(context).size.height;

    return EasySplashScreen(
      logo: Image.asset(
        'assets/singleiconWhite.png',
      ),
      showLoader: false,
      backgroundColor: MyColors.primaryBlue,
      futureNavigator: futureCall(),
      durationInSeconds: 5,
    );
  }
}
