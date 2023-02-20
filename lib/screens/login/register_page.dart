import 'package:e_commerce/controllers/login_controller.dart';
import 'package:e_commerce/main.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/screens/login/login_page.dart';
import 'package:e_commerce/services/reviews.dart';
import 'package:e_commerce/services/update_cart.dart';
import 'package:e_commerce/style/constants.dart';
import 'package:e_commerce/style/style.dart';
import 'package:e_commerce/tab_bar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../widgets/button.dart';
import '../../widgets/social_sign_button.dart';
import '../../widgets/text_field.dart';
import '../../widgets/text_link.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = "/RegisterPage";
  final LoginController c = Get.put(LoginController());

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController name = TextEditingController();

  TextEditingController email = TextEditingController();

  TextEditingController pass = TextEditingController();

  TextEditingController passagain = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

        // Once signed in, return the UserCredential
        if (unknownn) {
          return await FirebaseAuth.instance.currentUser
              ?.linkWithCredential(credential);
        } else {
          return await FirebaseAuth.instance.signInWithCredential(credential);
        }
        // return unknownn
        //     ? await FirebaseAuth.instance.currentUser
        //         ?.linkWithCredential(credential)
        //     : await FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
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
      favourates = [];

      db.collection("favourites").add({'id': uid, 'favourites': []});
    });
  }

  var boo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
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
              children: [
                const SizedBox(
                  height: 55,
                ),
                Center(child: Image.asset("assets/Icon1.png")),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Let’s Get Started',
                    style: title,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Text(
                    'Create an new account',
                    style: small112400150,
                  ),
                ),
                CustomTextField(
                  hintText: "Full Name",
                  cont: name,
                  onChanged: (h) {},
                  prefix: const Icon(
                    Icons.person_outline_outlined,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  hintText: "Your Email",
                  cont: email,
                  onChanged: (h) {},
                  prefix: const Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  hintText: "Password",
                  obscure: true,
                  cont: pass,
                  onChanged: (h) {},
                  prefix: const Icon(Icons.lock),
                ),
                const SizedBox(height: 5),
                CustomTextField(
                  hintText: "Password again",
                  obscure: true,
                  password: pass,
                  cont: passagain,
                  onChanged: (h) {},
                  prefix: const Icon(Icons.lock),
                ),
                const SizedBox(height: 12),
                CustomButon(
                  text: 'Sign Up',
                  onTap: () async {
                    // print("object");
                    if (_formKey.currentState!.validate()) {
                      try {
                        final Object credential;

                        if (FirebaseAuth.instance.currentUser != null) {
                          if (FirebaseAuth.instance.currentUser!.isAnonymous) {
                            credential = EmailAuthProvider.credential(
                              email: email.text,
                              password: pass.text,
                            );
                          } else {
                            credential = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: email.text,
                              password: pass.text,
                            );
                          }
                        } else {
                          credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: email.text,
                            password: pass.text,
                          );
                        }

                        var data = FirebaseAuth.instance.currentUser!;

                        db.collection("users").add({
                          "id": data.uid,
                          "birthdaty": null,
                          'name': ['${name.text}', ''],
                          "phoneNumber": null,
                          "email": email.text,
                          "gender": null,
                          "type": 0
                        });

                        user = UserModel(
                            name: [name.text, ""],
                            id: data.uid,
                            photoPath: "assets/avatar.jpg",
                            email: email.text,
                            type: 0);
                        setFavourites(data.uid);
                        await setCart();
                        await getReviews();

                        Get.offAllNamed(TabBarVieww.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          Get.snackbar(
                            "",
                            "",
                            snackPosition: SnackPosition.values[1],
                            backgroundColor: MyColors.neutralLight,
                            duration: const Duration(seconds: 2),
                            titleText: Text(
                              'The password provided is too weak.',
                              textAlign: TextAlign.center,
                              style: const MyStyles()
                                  .headingH5(MyColors.neutralDark),
                            ),
                          );
                          // print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          Get.snackbar(
                            "",
                            "",
                            snackPosition: SnackPosition.values[1],
                            backgroundColor: MyColors.neutralLight,
                            duration: const Duration(seconds: 2),
                            titleText: Text(
                              'The account already exists for that email.',
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
                  },
                ),
                const SizedBox(height: 12),
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
                    text: "Sign Up with Google",
                    onTap: boo
                        ? () async {
                            boo = false;
                            setState(() {});
                            //   await FirebaseAuth.instance.signOut();
                            //   FirebaseAuth.instance.signInAnonymously();
                            //   print(FirebaseAuth.instance.currentUser);
                            // },
                            try {
                              UserCredential? sign;
                              if (FirebaseAuth.instance.currentUser != null) {
                                if (FirebaseAuth
                                    .instance.currentUser!.isAnonymous) {
                                  // print('fdssss');

                                  sign = await signInWithGoogle(unknownn: true);
                                } else {
                                  print('fdssss');

                                  sign = await signInWithGoogle();
                                }
                              } else {
                                print('fdssss');

                                sign = await signInWithGoogle();
                              }
                              // print('fdssss');

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
                                        usr.displayName ??
                                            usr.providerData.first.displayName!,
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
                                    email: usr.email ??
                                        usr.providerData.first.email,
                                    type: 2,
                                  );
                                } else {
                                  user = UserModel(
                                    name: [
                                      data['name'].first,
                                      data['name'].last
                                    ],
                                    id: usr.uid,
                                    photoPath: usr.photoURL ??
                                        usr.providerData.first.photoURL,
                                    gender: data['gender'],
                                    birthdaty: data['birthdaty'],
                                    phoneNumber: data['phoneNumber'],
                                    email: usr.email ??
                                        usr.providerData.first.email,
                                    type: 2,
                                  );
                                }
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
                            boo = true;
                          }
                        : () {},
                    icon: Image.asset('assets/Google.png')

                    //  FaIcon(
                    //   FontAwesomeIcons.google,
                    //   color: co.primaryBlue,
                    // ),
                    //  Icon(
                    //   Icons.facebook,
                    //   color: Colors.blue,
                    // ),
                    ),
                const SizedBox(height: 5),
                CustomSocialButon(
                  onTap: () async {
                    FirebaseAuth.instance.signOut();
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
                              "name": [usr.displayName, ''],
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
                            email: usr.email ?? usr.providerData.first.email,
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
                        await setCart();

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
                        duration: const Duration(seconds: 11),
                        titleText: Text(
                          'Some thing went wrong please try again later $e.',
                          textAlign: TextAlign.center,
                          style:
                              const MyStyles().headingH5(MyColors.neutralDark),
                        ),
                      );
                    }
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.facebookF,
                    color: MyColors.primaryBlue,
                  ),
                  text: "Sign Up with facebook",
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'have an account? ',
                      style: small12700150,
                    ),
                    TextLink(
                      text: "Sign In ",
                      ontap: () {
                        Get.offAllNamed(LoginPage.id);
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
