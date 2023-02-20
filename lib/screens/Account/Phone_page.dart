import 'package:e_commerce/main.dart';

import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/fixed_title_app_bar.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/button.dart';

class Phone extends StatefulWidget {
  Phone({super.key});

  final ProfileDataController cont = Get.put(ProfileDataController());
  static String id = "/PhonePage";

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    phoneController.text = user!.phoneNumber ?? "";
  }

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
                          "Phone Number",
                          style:
                              const MyStyles().headingH5(MyColors.neutralDark),
                        ),
                        const SizedBox(height: 12),
                        TxtFieldPhone(controller: phoneController)
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
                        user!.phoneNumber = phoneController.text;
                        user!.update();

                        widget.cont.update();
                        Get.back();
                      }
                    } //=> Get.toNamed(.toet.toNamed(Shipto.id),
                    ),
              ),
              const FixedTitleAppBar(
                pageTitle: "Phone Number",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TxtFieldPhone extends StatelessWidget {
  TxtFieldPhone({
    super.key,
    required this.controller,
    this.onChanged,
    this.Prefix = const Text(""),
  });
  TextEditingController controller;
  Function(String)? onChanged;
  Widget? Prefix;

  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (data) {
        if (data!.isEmpty) {
          return 'field is required';
        } else if (!data.isPhoneNumber) {
          return 'enter a valid phone number';
        }
        return null;
      },
      onChanged: onChanged,
      style: const MyStyles().formtextfill(MyColors.neutralGrey),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.phone_android_outlined),
        hintText: "Enter New Phone number",
        hintStyle: const MyStyles().formtextnormal(MyColors.neutralGrey),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: MyColors.primaryRed,
          ),
        ),
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
