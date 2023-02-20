import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/screens/Account/email_page.dart';
import 'package:e_commerce/screens/Account/gender.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/profile_controller.dart';
import '../../widgets/fixed_title_app_bar.dart';
import 'Phone_page.dart';
import 'birth_day.dart';
import 'password_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static String id = "/ProfilePagePage";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 140),
                AvatarProfle(
                  user: user!,
                ),
                Expanded(
                  child: GetBuilder<ProfileDataController>(
                      init: ProfileDataController(),
                      builder: (_) {
                        return ListView(
                          padding: const EdgeInsets.all(0),
                          children: [
                            const SizedBox(height: 32),
                            Column(
                              children: [
                                // UserData(
                                //     title: "Name",
                                //     ontap: () {
                                //       user!.gender = null;
                                //       Get.to(() => ChangeName());
                                //     },
                                //     icon: Image.asset('assets/Gender.png'),
                                //     data: "${user!.name[0]} ${user!.name[1]}"),
                                UserData(
                                    title: "Gender",
                                    ontap: () => Get.to(() => Gender()),
                                    icon: Image.asset('assets/Gender.png'),
                                    data: user!.gender ?? "Choose Gender"),
                                UserData(
                                    title: "Birthday",
                                    ontap: () => Get.to(() => BirthDay()),
                                    icon: Image.asset('assets/Date.png'),
                                    data: user!.birthdaty == null
                                        ? "Enter Your Birthday"
                                        : DateFormat.yMMMEd()
                                            .format(user!.birthdaty!)),
                                user!.type == 0
                                    ? UserData(
                                        title: "Email",
                                        ontap: () => Get.to(() => Email()),
                                        icon: Image.asset('assets/Message.png'),
                                        data: user!.email!)
                                    : const SizedBox(
                                        height: 0,
                                      ),
                                UserData(
                                    title: "Phone Number",
                                    ontap: () => Get.to(() => Phone()),
                                    icon: Image.asset('assets/Phone.png'),
                                    data: user!.phoneNumber ??
                                        "Enter phone number"),
                                user!.type == 0
                                    ? UserData(
                                        title: "change Password",
                                        ontap: () => Get.to(() => Password()),
                                        icon:
                                            Image.asset('assets/Password.png'),
                                        data: "**********")
                                    : const SizedBox(
                                        height: 0,
                                      ),
                              ],
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }),
                ),
              ],
            ),
            const FixedTitleAppBar(
              pageTitle: "profile",
            ),
          ],
        ),
      ),
    );
  }
}

class AvatarProfle extends StatelessWidget {
  const AvatarProfle({super.key, required this.user});
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 74,
                  child: Stack(
                    clipBehavior: Clip.hardEdge,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 88),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("${user.name[0]} ${user.name[1]}",
                                          style: const MyStyles()
                                              .headingH5(MyColors.neutralDark)),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "@${user.email!.substring(0, user.email!.indexOf("@"))}",
                                        style: const MyStyles()
                                            .bodyTextNormalRegular(
                                          MyColors.neutralGrey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                              clipBehavior: Clip.hardEdge,
                              width: 72,
                              height: 72,
                              decoration: const BoxDecoration(
                                  color: primColor, shape: BoxShape.circle),
                              child: FirebaseAuth.instance.currentUser!
                                          .providerData.first.photoURL !=
                                      null
                                  ? Image.network(
                                      user.photoPath!,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      user.photoPath!,
                                      fit: BoxFit.fill,
                                    ))),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class UserData extends StatelessWidget {
  const UserData({
    Key? key,
    required this.title,
    required this.ontap,
    required this.icon,
    required this.data,
  }) : super(key: key);
  final String title;
  final Widget icon;
  final String data;

  final VoidCallback ontap;

  final MyStyles textStyle = const MyStyles();

  final MyColors colors = const MyColors();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: icon,
          ),
          Expanded(
            child: Text(
              title,
              style: textStyle.headingH5(MyColors.neutralDark),
            ),
          ),
          Text(
            data,
            style: const MyStyles().bodyTextNormalRegular(MyColors.neutralGrey),
          ),
          const SizedBox(
            width: 16,
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: Color(0xff9098B1),
          ),
        ],
      ),
    );
  }
}
