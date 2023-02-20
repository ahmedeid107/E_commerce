import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:e_commerce/main.dart';

import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/fixed_title_app_bar.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/button.dart';

class Gender extends StatefulWidget {
  Gender({super.key});

  final ProfileDataController cont = Get.put(ProfileDataController());
  static String id = "/GenderPage";

  @override
  State<Gender> createState() => _GenderState();
}

class _GenderState extends State<Gender> {
  SingleValueDropDownController gender = SingleValueDropDownController();

  @override
  void initState() {
    super.initState();
    if (user!.gender == null) {
    } else {
      if (user!.gender == "Male") {
        gender.dropDownValue =
            const DropDownValueModel(name: 'Male', value: "Male");
      } else if (user!.gender == "Female") {
        gender.dropDownValue =
            const DropDownValueModel(name: 'Female', value: "Female");
      }
    }
  }

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
                        "Choose Gender",
                        style: const MyStyles().headingH5(MyColors.neutralDark),
                      ),
                      const SizedBox(height: 12),
                      DropDownTextField(
                        controller: gender,
                        textFieldDecoration: InputDecoration(
                          hintText: "Choose Gender",
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
                        dropdownRadius: 5,
                        // initialValue: "name4",
                        clearOption: false,
                        padding: const EdgeInsets.all(100),
                        listSpace: 10,
                        listPadding: ListPadding(top: 10),
                        validator: (value) {
                          return null;

                          // if (value == null) {
                          //   return "Required field";
                          // } else {
                          //   return null;
                          // }
                        },
                        dropDownList: const [
                          DropDownValueModel(name: 'Male', value: "Male"),
                          DropDownValueModel(name: 'Female', value: "Female"),
                        ],
                        listTextStyle: const MyStyles()
                            .formtextnormal(MyColors.neutralGrey),
                        dropDownItemCount: 2,

                        onChanged: (val) {
                          //print(val.name);
                        },

                        textStyle:
                            const MyStyles().formtextfill(MyColors.neutralGrey),
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
                  text: "Save",
                  onTap: () async {
                    user!.gender = gender.dropDownValue == null
                        ? user!.gender
                        : gender.dropDownValue!.name;
                    await user!.update();
                    widget.cont.update();
                    Get.back();
                  } //=> Get.toNamed(Shipto.id),
                  ),
            ),
            const FixedTitleAppBar(
              pageTitle: "Gender",
            ),
          ],
        ),
      ),
    );
  }
}
