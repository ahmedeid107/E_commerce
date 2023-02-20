import 'dart:math';

import 'package:e_commerce/controllers/address_controller.dart';
import 'package:e_commerce/models/address.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:countries_utils/countries_utils.dart';

import '../../main.dart';
import '../../widgets/fixed_title_app_bar.dart';

class NewAddress extends StatefulWidget {
  NewAddress({super.key});
  static String id = "/NewAddressPage";
  final AddressController c = Get.put(AddressController());
  @override
  State<NewAddress> createState() => _NewAddressState();
}

class _NewAddressState extends State<NewAddress> {
  final String title = "titletitletitletitletitletitle title title title title";
  final FocusNode countriesFocus = FocusNode();
  static String? country;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool favourite = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController streatAddress = TextEditingController();
  TextEditingController streeatAddress2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController stateOrRegion = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.arguments is Addresss1) {
      Addresss1 addres = Get.arguments;
      firstName.text = addres.name.first;
      lastName.text = addres.name.last;
      streatAddress.text = addres.streatAddress;
      streeatAddress2.text = addres.streatAddress2 ?? "";
      city.text = addres.city;
      stateOrRegion.text = addres.state;
      zipCode.text = addres.zibCode;
      phone.text = addres.phoneNumber;
      country = addres.country;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    country = "";
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    var pageTitle =
        Get.arguments is Addresss1 ? "Edit address" : "Add new address";
    //print(MediaQuery.of(context).viewInsets.bottom);
    //print(height);
    List<String> suggestons = [];
    Countries.all().forEach((e) => suggestons.add(e.name!));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom > 100
                      ? MediaQuery.of(context).viewInsets.bottom
                      : (MediaQuery.of(context).viewInsets.bottom + 60)),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 140),
                            Text(
                              "Country Or ReGION",
                              textAlign: TextAlign.start,
                              style: const MyStyles()
                                  .headingH5(MyColors.neutralDark),
                            ),
                            const SizedBox(height: 12),
                            Focus(
                              focusNode: countriesFocus,
                              child: WillPopScope(
                                onWillPop: () async {
                                  if (countriesFocus.hasFocus) {
                                    countriesFocus.unfocus();
                                    return false;
                                  } else {
                                    return true;
                                  }
                                },
                                child: RawAutocomplete(
                                  optionsBuilder:
                                      (TextEditingValue textEditingValue) {
                                    List<String> matches = <String>[];
                                    matches.addAll(suggestons);

                                    matches.retainWhere((s) {
                                      return s.toLowerCase().contains(
                                          textEditingValue.text.toLowerCase());
                                    });
                                    return matches;
                                  },
                                  onSelected: (String selection) {
                                    //print('You just selected $selection');
                                  },
                                  fieldViewBuilder: (BuildContext context,
                                      TextEditingController
                                          textEditingController,
                                      FocusNode focusNode,
                                      VoidCallback onFieldSubmitted) {
                                    textEditingController.text = country ?? "";
                                    return TextFormField(
                                      onChanged: (f) {
                                        country = f;
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please Fill The Form';
                                        } else if (!suggestons
                                            .contains(value)) {
                                          return 'Invalid country name, please choose your country from list';
                                        }
                                      },
                                      textAlignVertical: TextAlignVertical.top,
                                      style: const MyStyles()
                                          .formtextfill(MyColors.neutralGrey),
                                      decoration: InputDecoration(
                                        errorMaxLines: 2,
                                        errorStyle: const MyStyles()
                                            .headingH6(MyColors.primaryRed),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: MyColors.primaryRed,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: MyColors.primaryRed,
                                          ),
                                        ),
                                        //   isDense: true,
                                        contentPadding: const EdgeInsets.only(
                                            left: 16, bottom: 10, top: 10),
                                        suffixIcon: Container(
                                          padding: const EdgeInsets.only(
                                            // top: 20,
                                            // left: 16,
                                            right: 16,
                                            // bottom: 20
                                          ),
                                          child: const Icon(
                                            Icons.arrow_drop_down,
                                            // color: co.neutralGrey,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: secColor,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                            color: primColor,
                                          ),
                                        ),
                                      ),
                                      controller: textEditingController,
                                      focusNode: focusNode,
                                      onFieldSubmitted: (String value) {},
                                    );
                                  },
                                  optionsViewBuilder: (BuildContext context,
                                      void Function(String) onSelected,
                                      Iterable<String> options) {
                                    return Container(
                                      height: 240,
                                      child: Column(
                                        children: [
                                          Material(
                                            child: Container(
                                              height: 240,
                                              child: ListView(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                shrinkWrap: true,
                                                //    physics: ClampingScrollPhysics(),
                                                children: options.map((opt) {
                                                  return InkWell(
                                                    onTap: () {
                                                      country = opt;
                                                      onSelected(opt);
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      height: 48,
                                                      width: double.infinity,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 16,
                                                          vertical: 10),
                                                      child: Text(
                                                        opt,
                                                        style: const MyStyles()
                                                            .formtextnormal(
                                                                MyColors
                                                                    .neutralGrey),
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextfieldAddress(
                                form: formKey,
                                data: "First Name",
                                controller: firstName,
                                fieldValidate: ""),
                            TextfieldAddress(
                                data: "Last Name",
                                controller: lastName,
                                fieldValidate: ""),
                            TextfieldAddress(
                                data: "Street Address",
                                controller: streatAddress,
                                fieldValidate: ""),
                            TextfieldAddress(
                                data: "Street Address 2 (Optional)",
                                controller: streeatAddress2,
                                fieldValidate: "optional"),
                            TextfieldAddress(
                                data: "City",
                                controller: city,
                                fieldValidate: ""),
                            TextfieldAddress(
                                data: "State/Province/Region",
                                controller: stateOrRegion,
                                fieldValidate: ""),
                            TextfieldAddress(
                                data: "Zip Code",
                                controller: zipCode,
                                fieldValidate: "code"),
                            TextfieldAddress(
                                data: "Phone Number",
                                controller: phone,
                                fieldValidate: "phone"),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FixedTitleAppBar(
              pageTitle: pageTitle,
              back2: true,
            ),
            Positioned(
              bottom: 15, // MediaQuery.of(context).viewInsets.bottom,
              child: Material(
                child: CustomButon(
                  text: Get.arguments is Addresss1
                      ? "Edit address"
                      : "Add new address",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      if (Get.arguments is Addresss1) {
                        Addresss1 adres = Get.arguments;
                        int indexOfAll = allAddresses
                            .indexWhere((element) => element.id == adres.id);
                        Addresss1 cc = allAddresses[indexOfAll];
                        cc.country = country!;
                        cc.city = city.text;
                        cc.name = [firstName.text, lastName.text];
                        cc.phoneNumber = phone.text;
                        cc.state = stateOrRegion.text;
                        cc.zibCode = zipCode.text;
                        cc.streatAddress = streatAddress.text;
                        cc.streatAddress2 = streeatAddress2.text;

                        db
                            .collection("Addresses")
                            .where("id", isEqualTo: adres.id)
                            .get()
                            .then((value) {
                          var docId = value.docs.first.id;
                          db.collection("Addresses").doc(docId).update({
                            'address': {
                              "country": country!,
                              "streatAddress": streatAddress.text,
                              "streatAddress2": streeatAddress2.text,
                              "city": city.text,
                              "state": stateOrRegion.text,
                              "zibCode": zipCode.text,
                              "phoneNumber": phone.text,
                              "name": [firstName.text, lastName.text],
                            }
                          });
                        });
                      } else {
                        String userId = FirebaseAuth.instance.currentUser!.uid;
                        int id = Random().nextInt(429496729);

                        allAddresses.add(Addresss1(
                            country: country!,
                            streatAddress: streatAddress.text,
                            streatAddress2: streeatAddress2.text,
                            city: city.text,
                            state: stateOrRegion.text,
                            zibCode: zipCode.text,
                            phoneNumber: phone.text,
                            name: [firstName.text, lastName.text],
                            userId: userId,
                            id: id));
                        db.collection("Addresses").add({
                          'address': {
                            "country": country!,
                            "streatAddress": streatAddress.text,
                            "streatAddress2": streeatAddress2.text,
                            "city": city.text,
                            "state": stateOrRegion.text,
                            "zibCode": zipCode.text,
                            "phoneNumber": phone.text,
                            "name": [firstName.text, lastName.text],
                          },
                          'userId': userId,
                          'id': id
                        });
                      }
                      widget.c.update();
                      Get.back();
                    }
                  },
                  width: width - 32,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextfieldAddress extends StatelessWidget {
  TextfieldAddress({
    Key? key,
    this.onChanged,
    required this.data,
    required this.controller,
    required this.fieldValidate,
    this.form,
  }) : super(key: key);
  Function(String)? onChanged;

  final String data;
  final String fieldValidate;
  final TextEditingController controller;
  final GlobalKey<FormState>? form;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data,
          style: const MyStyles().headingH5(MyColors.neutralDark),
        ),
        const SizedBox(height: 12),
        TxtField(
          form: form,
          controller: controller,
          hint: fieldValidate,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class TxtField extends StatelessWidget {
  TxtField({
    required this.controller,
    this.form,
    this.onChanged,
    required this.hint,
  });
  TextEditingController controller;
  Function(String)? onChanged;
  final String hint;
  final GlobalKey<FormState>? form;

  @override
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (data) {
        if (hint == "optional") {
        } else if (hint == "phone" && data!.isNotEmpty) {
          if (!data.isPhoneNumber) {
            return 'Invalid Phone number';
          }
        } else if (data!.isEmpty) {
          return 'Please Fill The Form';
        }
        return null;
      },
      onChanged: onChanged == null ? null : onChanged!(controller.text),
      style: const MyStyles().formtextfill(MyColors.neutralGrey),
      decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: MyColors.primaryRed,
          ),
        ),
        errorStyle: const MyStyles().headingH6(MyColors.primaryRed),
        hintText: null,
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
