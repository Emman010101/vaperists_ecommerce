import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/utils/close_screen.dart';

import '../utils/colors.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
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
                      "Select Shipping Address",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
