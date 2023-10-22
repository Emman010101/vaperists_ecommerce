import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/data/global_vars.dart';
import 'package:vaperists_ecommerce/utils/close_screen.dart';
import '../utils/colors.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SMSCodeScreen extends StatefulWidget {
  var verificationId;
  SMSCodeScreen({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<SMSCodeScreen> createState() => _SMSCodeScreenState();
}

class _SMSCodeScreenState extends State<SMSCodeScreen> {
  final _pinPutController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool smsCodeIsCorrect = true;

  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: textColor, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: textColor.withAlpha(150)),
        //borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: textColor),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: otpSubmittedColor,
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.red,
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
             SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            const Text(
              'Verification',
              style: TextStyle(
                color: textColor,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Enter the code sent to the number',
              style: TextStyle(
                color: textColor,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              '+639917377455',
              style: TextStyle(
                color: textColor,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.maxFinite,
              child: Form(
                key: _formKey,
                child: Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  validator: (value) {
                    return !smsCodeIsCorrect ? 'SMS code is incorrect' : null;
                  },
                  //pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) async {
                    smsCode = pin;
                    // Create a PhoneAuthCredential with the code
                    PhoneAuthCredential credential =
                    PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: smsCode);

                    // Sign the user in (or link) with the credential

                    try {
                      await FirebaseAuth.instance.signInWithCredential(credential);
                      closeScreen(context);
                    }  on FirebaseAuthException catch (e) {
                      //print("Error code: ${e.code}");
                      if (e.code == 'invalid-verification-code') {
                        smsCodeIsCorrect = false;
                        validateForm();
                        smsCodeIsCorrect = true;
                      }
                    }
                  },
                ),
              ),
            )
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
