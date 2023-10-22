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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Container(
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
