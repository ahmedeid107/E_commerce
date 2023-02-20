import 'package:e_commerce/screens/Account/birth_day.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/fixed_title_app_bar.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/button.dart';

class Email extends StatefulWidget {
  Email({super.key});

  final ProfileDataController cont = Get.put(ProfileDataController());
  static String id = "/EmailPage";
  DateTime? date = userModel.birthdaty;

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                          "Choose Email",
                          style:
                              const MyStyles().headingH5(MyColors.neutralDark),
                        ),
                        const SizedBox(height: 12),
                        TxtFieldEmail(controller: emailController)
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 15,
                child: CustomButon(
                    width: width - 32,
                    text: "Save",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        widget.cont.update();
                        Get.back();
                      }
                    } //= Get.toet.toNamed(Shipto.id),
                    ),
              ),
              const FixedTitleAppBar(
                pageTitle: "Email",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TxtFieldEmail extends StatelessWidget {
  TxtFieldEmail({
    required this.controller,
    this.onChanged,
    this.prefix = const Text(""),
  });
  TextEditingController controller;
  Function(String)? onChanged;
  Widget? prefix;

  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        } else if (!data.isEmail) {
          return 'enter a valid email';
        }
        return null;
      },
      onChanged: onChanged,
      style: const MyStyles().formtextfill(MyColors.neutralGrey),
      decoration: InputDecoration(
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: MyColors.primaryRed,
          ),
        ),
        prefixIcon: const Icon(Icons.email_outlined),
        hintText: "Enter New Email",
        hintStyle: const MyStyles().formtextnormal(MyColors.neutralGrey),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: MyColors.primaryRed,
          ),
        ),
        errorStyle: const MyStyles().headingH6(MyColors.primaryRed),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: secColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: primColor,
          ),
        ),
      ),
    );
  }
}
