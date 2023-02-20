import 'package:e_commerce/controllers/address_controller.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/address.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/fixed_title_app_bar.dart';
import 'new_address_page.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({super.key});
  static String id = "/AddressesPagePage";

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  final String title = "titletitletitletitletitletitle title title title title";

  final MyStyles textStyle = const MyStyles();
  bool favourite = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    numberOfPaddings() {
      if (width < 332) {
        return -1;
      } else if (width >= 332 && width < 498) {
        return 0;
      } else if (width > 498 && width < 664) {
        return 1;
      } else if (width > 664 && width < 830) {
        return 2;
      } else {
        return 1;
      }
    }

    delete() {
      //print("product deleted");
    }

    var n = numberOfPaddings().toInt();
    var pageTitle = 'Address';
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
                      text: "Add new adress",
                      onTap: () async {
                        Get.toNamed(NewAddress.id);
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
            ),
          ],
        ),
      ),
    );
  }
}

class AddressesList extends StatefulWidget {
  const AddressesList({super.key, required this.addresslist});
  final List<Addresss1> addresslist;

  @override
  State<AddressesList> createState() => _AddressesListState();
}

class _AddressesListState extends State<AddressesList> {
  int selected = 0;
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
            selected = index;
            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
                border: Border.all(
                  color: selected == index ? MyColors.primaryBlue : secColor,
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
                  text: "Yes",
                  width: 30,
                  onTap: () {
                    Get.back();
                    delete();
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                CustomButon(
                  text: "no",
                  width: 30,
                  onTap: () {
                    Get.back();
                  },
                  border: true,
                ),
              ],
            ),
          ),
        ]);
  }
}
