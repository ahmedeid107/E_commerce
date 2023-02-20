import 'package:e_commerce/style/constants.dart';
import 'package:flutter/material.dart';

import '../../models/notifiicationsModel.dart';
import '../../widgets/fixed_title_app_bar.dart';

class NotificatitonsPagesPuilder extends StatelessWidget {
  const NotificatitonsPagesPuilder({super.key, required this.dataClasss});
  final NotificationDataClass dataClasss;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    const SizedBox(height: 74),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        NotificationsPageSection(dataClasss: dataClasss),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: FixedTitleAppBar(
              pageTitle: dataClasss.pagetitle,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationsPageSection extends StatelessWidget {
  const NotificationsPageSection({
    Key? key,
    required this.dataClasss,
  }) : super(key: key);
  final NotificationDataClass dataClasss;

  @override
  Widget build(BuildContext context) {
    var keys = dataClasss.notificationData.keys.toList();
    //print(dataClasss.notificationData.values.elementAt(0));
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemCount: keys.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12, top: 4),
                child: dataClasss.notificationData[keys[index]]['iconOrImage']
                        is String
                    ? (dataClasss.pagetitle == NotificationDataClass.acivity
                        ? Image.asset(
                            dataClasss.notificationData[keys[index]]
                                ['iconOrImage'],
                            width: dataClasss.pagetitle ==
                                    NotificationDataClass.acivity
                                ? 24
                                : 48,
                            height: dataClasss.pagetitle ==
                                    NotificationDataClass.acivity
                                ? 24
                                : 48,
                            fit: BoxFit.fill,
                          )
                        : Image.network(
                            dataClasss.notificationData[keys[index]]
                                ['iconOrImage'],
                            width: dataClasss.pagetitle ==
                                    NotificationDataClass.acivity
                                ? 24
                                : 48,
                            height: dataClasss.pagetitle ==
                                    NotificationDataClass.acivity
                                ? 24
                                : 48,
                            fit: BoxFit.fill,
                          ))
                    : Icon(
                        dataClasss.notificationData[keys[index]]['iconOrImage'],
                        color: primColor,
                      ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      keys[index],
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff223263),
                          letterSpacing: .5,
                          height: 1.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        dataClasss.notificationData[keys[index]]['description'],
                        //       overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff9098B1),
                            letterSpacing: .5,
                            height: 1.5),
                      ),
                    ),
                    Text(
                      dataClasss.notificationData[keys[index]]['date'],
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff223263),
                          letterSpacing: .5,
                          height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
