import 'package:e_commerce/controllers/login_controller.dart';
import 'package:e_commerce/screens/login/forget_password.dart';
import 'package:e_commerce/screens/login/register_page.dart';
import 'package:e_commerce/services/reviews.dart';
import 'package:e_commerce/services/update_cart.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/widgets/text_link.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../main.dart';
import '../../models/user_model.dart';
import '../../tab_bar_view.dart';
import '../../widgets/button.dart';
import '../../widgets/social_sign_button.dart';
import '../../widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  static String id = "/LoginPage";
  LoginPage({super.key});
  final LoginController c = Get.put(LoginController());

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  getFavourites() async {
    favourates = await db
            .collection("favourites")
            .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) => value.docs.first['favourites']) ??
        [];
  }

  Future<UserCredential?> signInWithFacebook({var unknownn = false}) async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    if (loginResult.accessToken != null) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return unknownn
          ? FirebaseAuth.instance.currentUser
              ?.linkWithCredential(facebookAuthCredential)
          : FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } else {
      return null;
    }
  }

  Future<UserCredential?> signInWithGoogle({var unknownn = false}) async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      if (googleAuth != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, //?
          idToken: googleAuth.idToken, //?
        );
        // print("why");
        // Once signed in, return the UserCredential
        if (unknownn == true) {
          return await FirebaseAuth.instance.currentUser
              ?.linkWithCredential(credential);
        } else {
          return await FirebaseAuth.instance.signInWithCredential(credential);
          // print(await FirebaseAuth.instance.signInWithCredential(credential));
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  setFavourites(uid) async {
    await db
        .collection("favourites")
        .where("id", isEqualTo: uid)
        .get()
        .then((value) {
      favourates = value.docs.first['favourites'];
    }).catchError((e) {
      if (e.message == 'No element') {
        db.collection("favourites").add({'id': uid, 'favourites': []});
        favourates = [];
      }
    });
  }

  var boo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 130,
                ),
                Center(child: Image.asset("assets/Icon1.png")),
                Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Welcome to Lafyuu',
                      style: title,
                    )),
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 18),
                  child: Text(
                    'Sign in to continue',
                    style: small12400180,
                  ),
                ),
                CustomTextField(
                  hintText: "Your Email",
                  cont: email,
                  onChanged: (h) {},
                  email: true,
                  prefix: const Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  hintText: "Password",
                  obscure: true,
                  cont: pass,
                  onChanged: (h) {},
                  prefix: const Icon(Icons.lock),
                ),
                const SizedBox(height: 17),
                CustomButon(
                  text: 'Sign in',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: email.text,
                          password: pass.text,
                        );
                        var usr = FirebaseAuth.instance.currentUser!;

                        await db
                            .collection("users")
                            .where("id", isEqualTo: usr.uid)
                            .get()
                            .then((value) {
                          var data = value.docs.first.data();

                          user = UserModel(
                            name: [data['name'].first, data['name'].last],
                            id: data['id'],
                            photoPath: usr.photoURL ?? "assets/avatar.jpg",
                            gender: data['gender'],
                            birthdaty: data['birthdaty'],
                            phoneNumber: data['phoneNumber'],
                            email: usr.email,
                            type: data['type'],
                          );
                        });
                        await setCart();
                        await setFavourites(usr.uid);
                        await getReviews();
                        Get.offAllNamed(TabBarVieww.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          Get.snackbar(
                            "",
                            "",
                            snackPosition: SnackPosition.values[1],
                            backgroundColor: MyColors.neutralLight,
                            duration: const Duration(seconds: 2),
                            titleText: Text(
                              'No user found for that email.',
                              textAlign: TextAlign.center,
                              style: const MyStyles()
                                  .headingH5(MyColors.neutralDark),
                            ),
                          );
                          // print('The password provided is too weak.');
                        } else if (e.code == 'wrong-password') {
                          Get.snackbar(
                            "",
                            "",
                            snackPosition: SnackPosition.values[1],
                            backgroundColor: MyColors.neutralLight,
                            duration: const Duration(seconds: 2),
                            titleText: Text(
                              'Wrong password provided for that user.',
                              textAlign: TextAlign.center,
                              style: const MyStyles()
                                  .headingH5(MyColors.neutralDark),
                            ),
                          );
                          // 'The account already exists for that email.'
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
                  }
                  //  FirstApi().getdata()
                  ,
                ),
                const SizedBox(height: 15),
                Stack(
                  children: [
                    const Divider(
                      color: secColor,
                      thickness: 1,
                    ),
                    Center(
                      child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Text(
                            "OR",
                            style: TextStyle(
                                color: Color(0xff9098B1),
                                letterSpacing: .1,
                                fontWeight: FontWeight.w700),
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                CustomSocialButon(
                  icon: Image.asset('assets/Google.png'),
                  //  Icon(
                  //   Icons.facebook,
                  //   color: Colors.blue,
                  // ),
                  text: "Login with Google",
                  onTap: boo
                      ? () async {
                          boo = false;
                          setState(() {});
                          try {
                            UserCredential? sign;
                            if (FirebaseAuth.instance.currentUser != null) {
                              if (FirebaseAuth
                                  .instance.currentUser!.isAnonymous) {
                                sign = await signInWithGoogle(unknownn: true);
                              } else {
                                print("dssss");

                                sign = await signInWithGoogle();
                              }
                            } else {
                              sign = await signInWithGoogle();
                            }
                            // sign = await signInWithGoogle();

                            // var sign = await signInWithGoogle();
                            if (sign != null) {
                              var usr = FirebaseAuth.instance.currentUser!;
                              var data = {};
                              await db
                                  .collection("users")
                                  .where("id", isEqualTo: usr.uid)
                                  .get()
                                  .then((value) {
                                data = value.docs.first.data();
                              }).catchError((e) {
                                if (e.message == 'No element') {
                                  db.collection("users").add({
                                    "name": [
                                      usr.providerData.first.displayName,
                                      ''
                                    ],
                                    "id": usr.uid,
                                    "birthdaty": null,
                                    "phoneNumber": null,
                                    "gender": null,
                                    "type": 1,
                                  });
                                }
                              });
                              print("dssss");

                              if (data.isEmpty) {
                                user = UserModel(
                                  name: [
                                    usr.displayName ??
                                        usr.providerData.first.displayName!,
                                    ''
                                  ],
                                  id: usr.uid,
                                  photoPath: usr.photoURL ??
                                      usr.providerData.first.photoURL,
                                  gender: data['gender'],
                                  birthdaty: data['birthdaty'],
                                  phoneNumber: data['phoneNumber'],
                                  email: "usr.email",
                                  type: 1,
                                );
                              } else {
                                // print();

                                user = UserModel(
                                  name: [data['name'].first, data['name'].last],
                                  id: usr.uid,
                                  photoPath: usr.photoURL ??
                                      usr.providerData.first.photoURL,
                                  gender: data['gender'],
                                  birthdaty: data['birthdaty'],
                                  phoneNumber: data['phoneNumber'],
                                  email:
                                      usr.email ?? usr.providerData.first.email,
                                  type: 1,
                                );
                              }
                              print("dssss");
                              await setFavourites(usr.uid);

                              // await db
                              //     .collection("users")
                              //     .where("id", isEqualTo: usr.uid)
                              //     .get()
                              //     .then((value) {
                              //   var data = value.docs.first.data();

                              //   user = UserModel(
                              //     name: [data['name'].first, data['name'].last],
                              //     id: data['id'],
                              //     photoPath: usr.photoURL,
                              //     gender: data['gender'],
                              //     birthdaty: data['birthdaty'],
                              //     phoneNumber: data['phoneNumber'],
                              //     email: usr.email,
                              //     type: 1,
                              //   );
                              // }).catchError((e) {
                              //   print(e);
                              // });
                              // user = UserModel(
                              //     name: [!, ""],
                              //     id: data.uid,
                              //     photoPath: data.photoURL,
                              //     email: data.email,
                              //     type: 1);
                              await setCart();
                              await Future.delayed(const Duration(seconds: 3),
                                  () {
                                boo = true;
                                setState(() {});
                              });
                              await getReviews();
                              Get.offAllNamed(TabBarVieww.id);
                            }
                          } catch (e) {
                            Get.snackbar(
                              "",
                              "",
                              snackPosition: SnackPosition.values[1],
                              backgroundColor: MyColors.neutralLight,
                              duration: const Duration(seconds: 2),
                              titleText: Text(
                                'Some thing went wrong please try again later.$e',
                                textAlign: TextAlign.center,
                                style: const MyStyles()
                                    .headingH5(MyColors.neutralDark),
                              ),
                            );
                          }
                        }
                      : () {},
                ),
                const SizedBox(height: 5),
                CustomSocialButon(
                  icon: const FaIcon(
                    FontAwesomeIcons.facebookF,
                    color: MyColors.primaryBlue,
                  ),
                  text: "Login with facebook",
                  onTap: () async {
                    try {
                      UserCredential? sign;
                      if (FirebaseAuth.instance.currentUser != null) {
                        if (FirebaseAuth.instance.currentUser!.isAnonymous) {
                          sign = await signInWithFacebook(unknownn: true);
                        } else {
                          sign = await signInWithFacebook();
                        }
                      } else {
                        sign = await signInWithFacebook();
                      }
                      if (sign != null) {
                        var data = {};
                        var usr = FirebaseAuth.instance.currentUser!;

                        await db
                            .collection("users")
                            .where("id", isEqualTo: usr.uid)
                            .get()
                            .then((value) {
                          data = value.docs.first.data();
                        }).catchError((e) {
                          if (e.message == 'No element') {
                            db.collection("users").add({
                              "name": [
                                usr.displayName ??
                                    usr.providerData.first.displayName!,
                                ''
                              ],
                              "id": usr.uid,
                              "birthdaty": null,
                              "phoneNumber": null,
                              "gender": null,
                              "type": 2,
                            });
                          }
                        });
                        if (data.isEmpty) {
                          user = UserModel(
                            name: [
                              usr.displayName ??
                                  usr.providerData.first.displayName!,
                              ''
                            ],
                            id: usr.uid,
                            photoPath:
                                usr.photoURL ?? usr.providerData.first.photoURL,
                            gender: data['gender'],
                            birthdaty: data['birthdaty'],
                            phoneNumber: data['phoneNumber'],
                            email: "usr.email",
                            type: 2,
                          );
                        } else {
                          user = UserModel(
                            name: [data['name'].first, data['name'].last],
                            id: usr.uid,
                            photoPath:
                                usr.photoURL ?? usr.providerData.first.photoURL,
                            gender: data['gender'],
                            birthdaty: data['birthdaty'],
                            phoneNumber: data['phoneNumber'],
                            email: usr.email ?? usr.providerData.first.email,
                            type: 2,
                          );
                        }
                        await setFavourites(usr.uid);
                        await getReviews();
                        Get.offAllNamed(TabBarVieww.id);
                      }
                    } catch (e) {
                      // if(await FacebookAuth.instance.login().)
                      Get.snackbar(
                        "",
                        "",
                        snackPosition: SnackPosition.values[1],
                        backgroundColor: MyColors.neutralLight,
                        duration: const Duration(seconds: 2),
                        titleText: Text(
                          'Some thing went wrong please try again later $e.',
                          textAlign: TextAlign.center,
                          style:
                              const MyStyles().headingH5(MyColors.neutralDark),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextLink(
                  ontap: () => Get.toNamed(ForgetPassword.id),
                  text: "Forget Password?",
                ),
                const SizedBox(height: 7),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Don’t have a account? ',
                      style: small112400150,
                    ),
                    TextLink(
                      text: "Register",
                      ontap: () {
                        Get.toNamed(RegisterPage.id);
                      },
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    TextLink(
                      text: "Continue as a guest",
                      ontap: () async {
                        // FirebaseAuth.instance.signOut();
                        // print(FirebaseAuth.instance.currentUser!.uid);
                        if (FirebaseAuth.instance.currentUser == null) {
                          try {
                            final userCredential =
                                await FirebaseAuth.instance.signInAnonymously();

                            await setFavourites(
                                FirebaseAuth.instance.currentUser!.uid);
                            await setCart();

                            await getReviews();
                            Get.offAllNamed(TabBarVieww.id);
                          } on FirebaseAuthException catch (e) {
                            switch (e.code) {
                              default:
                                Get.snackbar(
                                  "",
                                  "",
                                  snackPosition: SnackPosition.values[1],
                                  backgroundColor: MyColors.neutralLight,
                                  duration: const Duration(seconds: 2),
                                  titleText: Text(
                                    'Some thing went wrong please try again later $e.',
                                    textAlign: TextAlign.center,
                                    style: const MyStyles()
                                        .headingH5(MyColors.neutralDark),
                                  ),
                                );
                            }
                          }
                        } else {
                          await setFavourites(
                              FirebaseAuth.instance.currentUser!.uid);
                          await setCart();

                          await getReviews();
                          Get.offAllNamed(TabBarVieww.id);
                        }

                        // Get.offAllNamed(TabBarVieww.id);
                      },
                      fontSize: 15,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
