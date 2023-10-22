import 'package:flutter/material.dart';

import '../utils/close_screen.dart';
import '../utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      body: SafeArea(
        child: Stack(
          children: [
            //top container
            Positioned(
              child: Container(
                padding: const EdgeInsets.only(
                    top: 10, right: 15, bottom: 10, left: 15),
                color: kBackgroundColor,
                height: screenHeight * 0.1,
                child: Row(
                  children: [
                    BackButton(
                      color: textColor,
                      onPressed: () async {
                        closeScreen(context);
                      },
                    ),
                    const Text(
                      "Checkout",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  //Ico
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
