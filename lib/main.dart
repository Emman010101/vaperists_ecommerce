import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/screens/home_screen.dart';
import 'package:vaperists_ecommerce/screens/login_screen.dart';
import 'package:vaperists_ecommerce/screens/sign-up_screen.dart';
import 'package:vaperists_ecommerce/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

  // name: 'vaperists',
  // options: const FirebaseOptions(
  // apiKey: "AIzaSyCK5oE9oQ8oyENtH2-cVXs0-mysWY2rgkE",
  // authDomain: "vaperists-4bdff.firebaseapp.com",
  // projectId: "vaperists-4bdff",
  // storageBucket: "vaperists-4bdff.appspot.com",
  // messagingSenderId: "616246995319",
  // appId: "1:616246995319:web:05ff525f4de8aefea69972",
  // measurementId: "G-TV670SLJLG",
  // )
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uid;
    try {
      uid = FirebaseAuth.instance.currentUser!.uid;
    } catch (e) {}
    return MaterialApp(
      theme: ThemeData(
          textTheme: const TextTheme(
        titleMedium: TextStyle(
          color: textColor,
        ),
      )),
      home: uid == null ? const LoginScreen() : const HomeScreen(),
      //home: const SignUpScreen(),
      debugShowCheckedModeBanner: false,
      title: "Vaperists",
    );
  }
}
