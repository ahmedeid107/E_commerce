import 'package:e_commerce/controllers/shipto_controller.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/address.dart';
import 'package:e_commerce/screens/Account/new_address_page.dart';
import 'package:e_commerce/screens/cart/payment_page.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/address_controller.dart';
import '../../widgets/fixed_title_app_bar.dart';

class Shipto extends StatefulWidget {
  Shipto({super.key});
  static String id = "/ShipToPage";
  final ShippingContrlloerer c = Get.put(ShippingContrlloerer());

  @override
  State<Shipto> createState() => _ShiptoState();
}

class _ShiptoState extends State<Shipto> {
  final MyStyles textStyle = const MyStyles();
  bool favourite = false;

  @override
  Widget build(BuildContext context) {
    var pageTitle = 'Ship to';
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
                      GetBuilder<AddressController>(
                        init: AddressController(),
                        initState: (_) {},
                        builder: (_) {
                          return AddressesList(addresslist: allAddresses);
                        },
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 16),
                    CustomButon(
                      text: "Next",
                      onTap: () {
                        if (allAddresses.isNotEmpty) {
                          if (widget.c.selected >= 0) {
                            Get.toNamed(PaymentPage.id,
                                arguments: allAddresses[widget.c.selected]);
                          } else {
                            Get.defaultDialog(
                                title: "No addresses selected",
                                titleStyle: textStyle.headingH2(neutralDark),
                                middleText:
                                    "Please select the address you want to ship to.",
                                // middleTextStyle: textStyle.bodyTextNormalRegular(co.neutralGrey),
                                buttonColor: MyColors.primaryBlue,
                                // cancelTextColor: Colors.white,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 20),
                                titlePadding: const EdgeInsets.only(top: 30),
                                actions: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                      top: 0,
                                      bottom: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomButon(
                                          text: "Ok",
                                          width: 30,
                                          color: MyColors.primaryBlue,
                                          textcolor: MyColors.backgroundWhite,
                                          onTap: () {
                                            Get.back();
                                          },
                                          border: true,
                                        ),
                                        // SizedBox(
                                        //   width: 20,
                                        // ),
                                        // CustomButon(
                                        //   text: "No",
                                        //   width: 30,
                                        //   onTap: () => Get.back(),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ]);
                          }
                        } else {
                          Get.defaultDialog(
                              title: "No addresses added",
                              titleStyle: textStyle.headingH2(neutralDark),
                              middleText: "Please add one address atleast.",
                              // middleTextStyle: textStyle.bodyTextNormalRegular(co.neutralGrey),
                              buttonColor: MyColors.primaryBlue,
                              // cancelTextColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 20),
                              titlePadding: const EdgeInsets.only(top: 30),
                              actions: [
                                Container(
                                  padding: const EdgeInsets.only(
                                    top: 0,
                                    bottom: 15,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomButon(
                                        text: "Ok",
                                        width: 30,
                                        color: MyColors.primaryBlue,
                                        textcolor: MyColors.backgroundWhite,
                                        onTap: () {
                                          Get.back();
                                        },
                                        border: true,
                                      ),
                                      // SizedBox(
                                      //   width: 20,
                                      // ),
                                      // CustomButon(
                                      //   text: "No",
                                      //   width: 30,
                                      //   onTap: () => Get.back(),
                                      // ),
                                    ],
                                  ),
                                ),
                              ]);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                )
              ],
            ),
            FixedTitleAppBar(
              pageTitle: pageTitle,
              back2: true,
              icon: Icons.add,
              color: MyColors.primaryBlue,
              onTap: () => Get.toNamed(NewAddress.id),
            ),
          ],
        ),
      ),
    );
  }
}

class AddressesList extends StatefulWidget {
  AddressesList({super.key, required this.addresslist});
  final List<Addresss1> addresslist;
  final ShippingContrlloerer c = Get.put(ShippingContrlloerer());

  @override
  State<AddressesList> createState() => _AddressesListState();
}

class _AddressesListState extends State<AddressesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.addresslist.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          hoverColor: Colors.transparent,
          focusColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            widget.c.selected = index;
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: widget.c.selected == index
                      ? MyColors.primaryBlue
                      : secColor,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      '${widget.addresslist[index].name.first} ${widget.addresslist[index].name.last}',
                      style: const MyStyles().headingH5(
                        MyColors.neutralDark,
                      )),
                ),
                const SizedBox(height: 16),
                Text(
                  '${widget.addresslist[index].streatAddress} ${widget.addresslist[index].city} ,',
                  style: const MyStyles().bodyTextNormalRegular(
                    MyColors.neutralGrey,
                  ),
                ),
                Text(
                  '${widget.addresslist[index].state} ${widget.addresslist[index].zibCode} ${widget.addresslist[index].country} ',
                  style: const MyStyles().bodyTextNormalRegular(
                    MyColors.neutralGrey,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.addresslist[index].phoneNumber,
                  style: const MyStyles().bodyTextNormalRegular(
                    MyColors.neutralGrey,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CustomButon(
                      text: "Edit",
                      width: 77,
                      onTap: () {
                        Get.toNamed(NewAddress.id,
                            arguments: widget.addresslist[index]);
                      },
                    ),
                    const SizedBox(width: 24),
                    Material(
                        child: InkWell(
                            onTap: () async {
                              dialogmethod(() async {
                                await db
                                    .collection('Addresses')
                                    .where(
                                      "userId",
                                      isEqualTo:
                                          widget.addresslist[index].userId,
                                    )
                                    .where('id',
                                        isEqualTo: widget.addresslist[index].id)
                                    .get()
                                    .then((value) {
                                  var uid = value.docs.first.id;
                                  db.collection('Addresses').doc(uid).delete();
                                }).catchError((e) {});
                                widget.addresslist.removeAt(index);
                                setState(() {});
                              });
                            },
                            child: const Icon(Icons.delete_outline))),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void dialogmethod(Function() delete) {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 40),
        titlePadding: const EdgeInsets.only(top: 30),
        title: "Delete this Address",
        titleStyle: const MyStyles().headingH2(neutralDark),
        middleText: "Are you shure you want to delete this address ",
        middleTextStyle:
            const MyStyles().bodyTextNormalRegular(MyColors.neutralGrey),
        buttonColor: MyColors.primaryBlue,
        cancelTextColor: Colors.white,
        actions: [
          Container(
            padding: const EdgeInsets.only(
              top: 0,
              bottom: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButon(
                  text: "no",
                  width: 30,
                  onTap: () {
                    Get.back();
                  },
                  border: true,
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomButon(
                  text: "Yes",
                  width: 30,
                  onTap: () {
                    Get.back();
                    delete();
                  },
                ),
              ],
            ),
          ),
        ]);
  }
}
