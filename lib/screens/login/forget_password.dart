import 'package:e_commerce/screens/login/reset_success.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/fixed_title_app_bar.dart';
import '../../controllers/profile_controller.dart';
import '../../widgets/button.dart';

class ForgetPassword extends StatefulWidget {
  ForgetPassword({super.key});

  final ProfileDataController cont = Get.put(ProfileDataController());
  static String id = "/ForgetPasswordPage";

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
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
                          "Write your Email",
                          style:
                              const MyStyles().headingH5(MyColors.neutralDark),
                        ),
                        const SizedBox(height: 16),
                        TxtFieldEmail(controller: emailController),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 15,
                child: CustomButon(
                    width: width - 32,
                    text: "Send",
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: emailController.text);
                          Get.offNamed(ResetSuccess.id);
                          // widget.cont.update();
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            Get.snackbar(
                              "",
                              "",
                              snackPosition: SnackPosition.values[1],
                              backgroundColor: MyColors.neutralLight,
                              duration: const Duration(seconds: 9),
                              titleText: Text(
                                'No user found for that email.',
                                textAlign: TextAlign.center,
                                style: const MyStyles()
                                    .headingH5(MyColors.neutralDark),
                              ),
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            "",
                            "",
                            snackPosition: SnackPosition.values[1],
                            backgroundColor: MyColors.neutralLight,
                            duration: const Duration(seconds: 9),
                            titleText: Text(
                              'Some thing went wrong please try again later $e.',
                              textAlign: TextAlign.center,
                              style: const MyStyles()
                                  .headingH5(MyColors.neutralDark),
                            ),
                          );
                        }
                      }

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

class TxtFieldPassword extends StatefulWidget {
  TxtFieldPassword({
    super.key,
    required this.controller,
    this.onChanged,
    this.prefix = const Text(""),
    required this.index,
    this.password,
  });
  TextEditingController controller;
  TextEditingController? password;
  final int index;
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
      if (i == 1) {
        return "Enter new Password";
      } else if (i == 2) {
        return "Enter new Password again";
      }
    }

    return TextFormField(
      obscureText: obscure,
      controller: widget.controller,
      validator: (data) {
        if (widget.index == 2) {
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

class TxtFieldEmail extends StatelessWidget {
  TxtFieldEmail({
    super.key,
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
