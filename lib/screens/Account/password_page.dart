import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/fixed_title_app_bar.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/button.dart';

class Password extends StatefulWidget {
  Password({super.key});

  final ProfileDataController cont = Get.put(ProfileDataController());
  static String id = "/PasswordPage";

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordAgain = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //print(userModel.password);
    var width = MediaQuery.of(context).size.width;
    //print(newPassword.runtimeType);
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
                          "Old Password",
                          style:
                              const MyStyles().headingH5(MyColors.neutralDark),
                        ),
                        const SizedBox(height: 12),
                        GetBuilder<ProfileDataController>(
                          builder: (_) {
                            return TxtFieldPassword(
                              controller: oldPassword,
                              index: 0,
                              password: newPassword,
                              passCheck: widget.cont.check,
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "New Password",
                          style:
                              const MyStyles().headingH5(MyColors.neutralDark),
                        ),
                        const SizedBox(height: 12),
                        TxtFieldPassword(
                          controller: newPassword,
                          index: 1,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "New Password Again",
                          style:
                              const MyStyles().headingH5(MyColors.neutralDark),
                        ),
                        const SizedBox(height: 12),
                        TxtFieldPassword(
                          controller: newPasswordAgain,
                          index: 2,
                          password: newPassword,
                        )
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
                      await Future.delayed(const Duration(seconds: 0),
                          () async {
                        widget.cont.check = await _checkPass(oldPassword.text);
                        setState(() {});
                        widget.cont.update();
                      });

                      if (_formKey.currentState!.validate()) {
                        widget.cont.update();

                        await _changePassword(
                            oldPassword.text, newPassword.text);
                        // Get.back();
                      }

                      // //print();
                    } //=> Get.toNamed(.toet.toNamed(Shipto.id),
                    ),
              ),
              const FixedTitleAppBar(
                pageTitle: "Password Number",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _checkPass(String currentPassword) async {
    bool? h1;

    final user1 = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user1!.email!, password: currentPassword);
    await user1.reauthenticateWithCredential(cred).then((value) {
      h1 = true;
    }).catchError((err) {
      h1 = false;
    });
    return h1!;
  }

  Future<bool> _changePassword(
      String currentPassword, String newPassword) async {
    bool? h1;

    final user1 = FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: user1!.email!, password: currentPassword);
    await user1.reauthenticateWithCredential(cred).then((value) {
      h1 = true;

      user1.updatePassword(newPassword).then((_) {
        //Success, do something

        h1 = true;
      }).catchError((error) {
        h1 = false;

        //Error, show something
      });
    }).catchError((err) {
      h1 = false;
    });
    return h1!;
  }
}

class TxtFieldPassword extends StatefulWidget {
  TxtFieldPassword({
    super.key,
    required this.controller,
    this.onChanged,
    this.passCheck,
    this.prefix = const Text(""),
    required this.index,
    this.password,
  });
  TextEditingController controller;
  TextEditingController? password;
  final int index;
  bool? passCheck;

  Function(String)? onChanged;
  Widget? prefix;

  @override
  State<TxtFieldPassword> createState() => _TxtFieldPasswordState();
}

class _TxtFieldPasswordState extends State<TxtFieldPassword> {
  bool obscure = true;

  @override
  @override
  Widget build(BuildContext context) {
    hint(i) {
      if (i == 0) {
        return "Enter old Password";
      } else if (i == 1) {
        return "Enter new Password";
      } else if (i == 2) {
        return "Enter new Password again";
      }
    }

    return TextFormField(
      obscureText: obscure,
      controller: widget.controller,
      validator: (data) {
        // print(" fk${widget.passCheck}");

        if (widget.index == 0) {
          if (data!.isEmpty) {
            return 'this field is required';
          } else if (!widget.passCheck!) {
            return ' Oops! Your Password Is Not Correct ';
          }
        } else if (widget.index == 2) {
          if (data!.isEmpty) {
            return 'this field is required';
          } else if (data != widget.password!.text) {
            return ' Passwords do not match ';
          }
        } else if (widget.index == 1) {
          if (data!.isEmpty) {
            return 'this field is required';
          } else {
            return null;
          }
        }
        return null;
      },
      onChanged: (s) {
        setState(() {});
      },
      style: const MyStyles().formtextfill(MyColors.neutralGrey),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_outline),
        hintText: hint(widget.index),
        suffixIcon: InkWell(
            onTap: () {
              obscure = !obscure;
              setState(() {});
            },
            child: Icon(!obscure ? Icons.visibility : Icons.visibility_off)),
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
