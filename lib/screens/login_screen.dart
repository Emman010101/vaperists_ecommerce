import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/data/firestore_crud.dart';
import 'package:vaperists_ecommerce/screens/home_screen.dart';
import 'package:vaperists_ecommerce/screens/sms_code_screen.dart';
import 'package:vaperists_ecommerce/utils/close_screen.dart';
import 'package:vaperists_ecommerce/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaperists_ecommerce/utils/snackbar.dart';

import '../data/firebase_auth.dart';
import '../data/global_vars.dart';
import '../utils/screen_opener.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber = '';
  bool isLoading = false;
  bool isPhoneNumberValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Vaperists',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 40,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //email input field
                    TextFormField(
                      validator: (value) {
                        phoneNumber = value.toString();
                        if (value!.isEmpty) {
                          return 'Phone number must not be empty.';
                        } else if (!isPhoneNumberValid) {
                          return 'The provided phone number is not valid.';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          FontAwesomeIcons.phone,
                          color: textColor,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textColor),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textColor),
                        ),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: textColor),
                        ),
                        hintText: "Phone number",
                        hintStyle: TextStyle(
                          color: textColor.withAlpha(200),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child:
                          //sign up button
                          ElevatedButton(
                        onPressed: () async {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => HomeScreen(),
                          //   ),
                          // );
                          // if (Navigator.canPop(context)) {
                          //   Navigator.pop(context);
                          // }
                          if (validateForm() && !isLoading) {
                            //loadingDialog(context);
                            setState(() {
                              isLoading = true;
                            });
                            // await createPasswordBasedAcc(phoneNumber, password1);
                            /////
                            phoneNumber =
                                phoneNumber.substring(1, phoneNumber.length);
                            FirebaseAuth auth = FirebaseAuth.instance;
                            await auth.verifyPhoneNumber(
                              //'+44 7123 123 456'
                              phoneNumber: "+63${phoneNumber}",
                              verificationCompleted:
                                  (PhoneAuthCredential credential) async {
                                await auth.signInWithCredential(credential);
                                closeScreen(context);
                                openScreen(context, HomeScreen());
                              },
                              verificationFailed: (FirebaseAuthException e) {
                                print(e.code);
                                if (e.code == 'invalid-phone-number') {
                                  //print();
                                  isPhoneNumberValid = false;
                                  validateForm();
                                  isPhoneNumberValid = true;
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                              codeSent: (String verificationId,
                                  int? resendToken) async {
                                // Update the UI - wait for the user to enter the SMS code
                                await openScreen(context, SMSCodeScreen(verificationId: verificationId,));
                                await createFirstTimeUser();
                                closeScreen(context);
                                openScreen(context, HomeScreen());
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                            /////
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(textColor),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              // Change your radius here
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                        child: isLoading
                            ? const Text('Logging in....',
                                style: TextStyle(color: Colors.black))
                            : const Text(
                                'Login',
                                style: TextStyle(color: Colors.black),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 0),
              child: Column(
                children: [
                  const Text(
                    'or sign-up with',
                    style: TextStyle(color: textColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //google sign-in button
                      IconButton(
                        icon: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset('assets/images/googlelogo.png'),
                        ),
                        iconSize: 50,
                        onPressed: () async {
                          await signInWithGoogle();
                          await createFirstTimeUser();
                          closeScreen(context);
                        },
                      ),
                      //facebook sign-in button
                      IconButton(
                        icon: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset('assets/images/facebooklogo.png'),
                        ),
                        iconSize: 50,
                        onPressed: () async {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool validateForm() {
    final FormState? form = _formKey.currentState;
    bool isValid = false;
    if (form!.validate()) {
      print('Form is valid');
      isValid = true;
    } else {
      print('Form is invalid');
      isValid = false;
    }
    return isValid;
  }
}
