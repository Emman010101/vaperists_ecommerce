import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaperists_ecommerce/utils/screen_opener.dart';

import '../screens/login_screen.dart';

Future userLoggedInChecker(context) async {
  try {
    FirebaseAuth.instance.currentUser!.email;
  } catch (e) {
    await openScreen(context, const LoginScreen());
  }
}
