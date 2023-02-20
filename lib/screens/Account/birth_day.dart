import 'package:date_field/date_field.dart';
import 'package:e_commerce/main.dart';

import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/fixed_title_app_bar.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/button.dart';

var userModel = UserModel.fromJson(firstUser);

class BirthDay extends StatefulWidget {
  BirthDay({super.key});

  final ProfileDataController cont = Get.put(ProfileDataController());
  static String id = "/BirthDayPage";

  @override
  State<BirthDay> createState() => _BirthDayState();
}

class _BirthDayState extends State<BirthDay> {
  TextEditingController date = TextEditingController();
  DateTime? datee = user!.birthdaty;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(height: 74),
                      Text(
                        "Your Birhday",
                        style: const MyStyles().headingH5(MyColors.neutralDark),
                      ),
                      const SizedBox(height: 12),
                      DateTimeField(
                          initialDate: datee,
                          dateTextStyle: const MyStyles()
                              .formtextfill(MyColors.neutralGrey),
                          mode: DateTimeFieldPickerMode.date,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.date_range),
                            hintText: "Enter Your Birthday",
                            hintStyle: const MyStyles()
                                .formtextnormal(MyColors.neutralGrey),
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
                          onDateSelected: (f) {
                            datee = f;

                            setState(() {});
                          },
                          selectedDate: datee) //widget.date),
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
                    user!.birthdaty = datee ?? user!.birthdaty;

                    user!.update();
                    widget.cont.update();
                    Get.back();
                  } //=> Get.toet.toNamed(Shipto.id),
                  ),
            ),
            const FixedTitleAppBar(
              pageTitle: "Birthd8ay",
            ),
          ],
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
          return 'field is required';
        }
        return null;
      },
      onChanged: onChanged,
      style: const MyStyles().formtextfill(MyColors.neutralGrey),
      decoration: InputDecoration(
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
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return DateTimeFormField(
      decoration: const InputDecoration(
        hintStyle: TextStyle(color: Colors.black45),
        errorStyle: TextStyle(color: Colors.redAccent),
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.event_note),
        //  labelText: 'Only time',
      ),
      mode: DateTimeFieldPickerMode.date,
      autovalidateMode: AutovalidateMode.always,
      validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
      onDateSelected: (DateTime value) {
        //print(value);
      },
    );
  }
}
