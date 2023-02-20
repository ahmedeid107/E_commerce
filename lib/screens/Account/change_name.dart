import 'package:e_commerce/main.dart';

import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/fixed_title_app_bar.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/button.dart';

class ChangeName extends StatefulWidget {
  ChangeName({super.key});

  final ProfileDataController cont = Get.put(ProfileDataController());
  static String id = "/ChangeNamePage";

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  TextEditingController first = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController second = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    first.text = user!.name.first;
    second.text = user!.name.last;
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
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        const SizedBox(height: 74),
                        Text(
                          "First Name",
                          style:
                              const MyStyles().headingH5(MyColors.neutralDark),
                        ),
                        const SizedBox(height: 12),
                        TxtField(
                          controller: first,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Last Name",
                          style:
                              const MyStyles().headingH5(MyColors.neutralDark),
                        ),
                        const SizedBox(height: 12),
                        TxtField(
                          controller: second,
                        ),
                        const SizedBox(height: 16),
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
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        user!.name.first = first.value.text;
                        user!.name.last = second.value.text;
                        widget.cont.update();
                        await user!.update();
                        Get.back();
                      }
                    }),
              ),
              const FixedTitleAppBar(
                pageTitle: "Change Name",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TxtField extends StatelessWidget {
  TxtField({
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
          //print("object");

          return 'Please Fill The Form';
        }
        return null;
      },
      onChanged: onChanged,
      style: const MyStyles().formtextfill(MyColors.neutralGrey),
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: MyColors.primaryRed,
          ),
        ),
        errorStyle: const MyStyles().headingH6(MyColors.primaryRed),
        hintText: "Enter New Name",
        hintStyle: const MyStyles().formtextnormal(MyColors.neutralGrey),
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
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: MyColors.primaryRed,
          ),
        ),
      ),
    );
  }
}
