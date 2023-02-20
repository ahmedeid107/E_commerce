import 'package:e_commerce/style/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/notifiicationsModel.dart';
import 'notifications_pages_puilder.dart';

class NotificatitonPage extends StatelessWidget {
  const NotificatitonPage({super.key});
  static String id = "/Notificatiton";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 20, top: 15, right: 16, left: 16),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6.0, top: 5),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          right: 0, left: 8, top: 3, bottom: 3),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                        color: Color(0xff9098B1),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Text(
                  'Notification',
                  style: title,
                )),
              ],
            ),
          ),
          const Divider(
            height: 1,
            color: secColor,
            thickness: 1,
          ),
          Column(
            children: [
              PotificationWidgets(
                  onTap: () {
                    Get.to(() => NotificatitonsPagesPuilder(
                        dataClasss: NotificationDataClass.fromJson(
                            NotificationDataClass.offer,
                            notificationDataicon)));
                  },
                  icon: Icons.local_offer_outlined,
                  widgetTitle: "Offer",
                  num: 3),
              PotificationWidgets(
                onTap: () {
                  Get.to(() => NotificatitonsPagesPuilder(
                      dataClasss: NotificationDataClass.fromJson(
                          NotificationDataClass.feed, notificationData)));
                },
                icon: Icons.feed_outlined,
                widgetTitle: "Feed",
                num: 4,
              ),
              PotificationWidgets(
                  onTap: () {
                    Get.to(() => NotificatitonsPagesPuilder(
                        dataClasss: NotificationDataClass.fromJson(
                            NotificationDataClass.acivity,
                            notificationDataiconact)));
                  },
                  icon: Icons.notifications_outlined,
                  widgetTitle: "Activity",
                  num: 3)
            ],
          )
        ],
      ),
    );
  }
}

class PotificationWidgets extends StatelessWidget {
  const PotificationWidgets({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.widgetTitle,
    required this.num,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final String widgetTitle;
  final int num;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(
                icon,
                color: primColor,
              ),
            ),
            Expanded(
                child: Text(
              widgetTitle,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff223263),
                  letterSpacing: .5,
                  height: 1.5),
            )),
            Container(
                decoration: const BoxDecoration(
                  color: Color(0xffFB7181),
                  shape: BoxShape.circle,
                  //   borderRadius: BorderRadius.all(Radius.circular(5))
                ),
                width: 20,
                height: 20,
                child: Center(
                    child: Text("$num",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          letterSpacing: .5,
                          height: 1.5,
                        ))))
          ],
        ),
      ),
    );
  }
}
