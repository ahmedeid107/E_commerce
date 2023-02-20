import 'package:e_commerce/main.dart';
import 'package:flutter/material.dart';

class NotificationDataClass {
  final String pagetitle;

  final Map notificationData;

  NotificationDataClass({
    required this.pagetitle,
    required this.notificationData,
  });
  static String offer = "Offer";
  static String feed = "Feedoutfeed";
  static String acivity = "Acivity";

  factory NotificationDataClass.fromJson(title, jsondata) {
    return NotificationDataClass(
      pagetitle: title,
      notificationData: jsondata,
    );
  }
}

var notificationData = {
  'The Best Title': {
    'iconOrImage': allProducts[7].image[0],
    'description':
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
    'date': "April 30, 2014 1:01 PM",
  },
  'The Best Title1': {
    'iconOrImage': allProducts[10].image[0],
    'description':
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
    'date': "April 30, 2014 1:01 PM",
  },
  'The Best Title2': {
    'iconOrImage': allProducts[12].image[0],
    'description':
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
    'date': "April 30, 2014 1:01 PM",
  },
  'The Best Title3': {
    'iconOrImage': allProducts[14].image[0],
    'description':
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
    'date': "April 30, 2014 1:01 PM",
  },
};

var notificationDataicon = {
  'The Best Title': {
    'iconOrImage': Icons.feed_outlined,
    'description':
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
    'date': "April 30, 2014 1:01 PM",
  },
  'The Best Title1': {
    'iconOrImage': Icons.feed_outlined,
    'description':
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
    'date': "April 30, 2014 1:01 PM",
  },
  'The Best Title2': {
    'iconOrImage': Icons.feed_outlined,
    'description':
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
    'date': "April 30, 2014 1:01 PM",
  },
};
var notificationDataiconact = {
  'The Best Title': {
    'iconOrImage': 'assets/Transaction.png',
    'description':
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
    'date': "April 30, 2014 1:01 PM",
  },
  'The Best Title1': {
    'iconOrImage': 'assets/Transaction.png',
    'description':
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
    'date': "April 30, 2014 1:01 PM",
  },
  'The Best Title2': {
    'iconOrImage': 'assets/Transaction.png',
    'description':
        "Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo",
    'date': "April 30, 2014 1:01 PM",
  },
};
