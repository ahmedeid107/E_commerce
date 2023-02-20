import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:get/state_manager.dart';

class HomePageController extends GetxController {
  late TabController tabController;
}

class flashtimer extends GetxController {
  String? timeH;
  String? timeM;
  String? timeS;

  @override
  void onInit() {
    timeMethod();
    Timer.periodic(const Duration(seconds: 1), (_) => timeMethod());
    super.onInit();
  }

  void timeMethod() {
    var formatter = NumberFormat("00");
    timeH = formatter.format(23 - DateTime.now().hour).toString();
    timeM = formatter.format(59 - DateTime.now().minute).toString();
    timeS = formatter.format(59 - DateTime.now().second).toString();
    update();
  }
}



//    final Controller c = Get.put(Controller());
