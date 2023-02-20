import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/fixed_title_app_bar.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/button.dart';

class ResetSuccess extends StatefulWidget {
  ResetSuccess({super.key});

  final ProfileDataController cont = Get.put(ProfileDataController());
  static String id = "/ResetSuccessPage";

  @override
  State<ResetSuccess> createState() => _ResetSuccessState();
}

class _ResetSuccessState extends State<ResetSuccess> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordAgain = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //print(userModel.password);
    var width = MediaQuery.of(context).size.width;
    //print(newPassword.runtimeType);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 74),
                        Text(
                          "A reset password link has been sent to your email please check it to enter your new password",
                          style:
                              const MyStyles().headingH4(MyColors.neutralDark),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 15,
                child: CustomButon(
                    width: width - 32,
                    text: "Go back to login page",
                    onTap: () async {
                      Get.back();

                      // //print();
                    } //=> Get.toNamed(.toet.toNamed(Shipto.id),
                    ),
              ),
              const FixedTitleAppBar(
                pageTitle: "Forget password",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
