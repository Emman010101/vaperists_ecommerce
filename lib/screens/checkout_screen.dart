import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/data/firestore_crud.dart';
import 'package:vaperists_ecommerce/screens/address_screen.dart';
import 'package:vaperists_ecommerce/utils/screen_opener.dart';

import '../data/global_vars.dart';
import '../utils/close_screen.dart';
import '../utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../widgets/firebase_image.dart';

class CheckoutScreen extends StatefulWidget {
  List<dynamic> isItemChecked = [];

  CheckoutScreen({super.key, required this.isItemChecked});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var uid = FirebaseAuth.instance.currentUser!.uid;

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
            FutureBuilder<FinalCartItems?>(
                future: readCartForCheckout(uid, widget.isItemChecked),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(
                      child: Text(
                        'Your cart is empty',
                        style: TextStyle(color: textColor),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    FinalCartItems? cartItems = snapshot.data;

                    return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: cartItems?.currentPrice.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: index == 0
                                    ? (MediaQuery.of(context).size.height) *
                                    0.23
                                    : 0,
                              ),
                              Container(
                                padding: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: productWidgetBg,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                      offset: const Offset(1, 1),
                                    )
                                  ],
                                ),
                                margin: const EdgeInsets.only(
                                  bottom: 5,
                                  top: 5,
                                  left: 5,
                                  right: 5,
                                ),
                                child: Row(
                                  children: [
                                    map.isEmpty ||
                                        cartItems!.imageName.length >
                                            map.length
                                        ? FirebaseImage(
                                      fileName:
                                      cartItems?.imageName[index],
                                      width: screenWidth * 0.3,
                                      height: screenHeight * 0.2,
                                    )
                                        : CachedNetworkImage(
                                      imageUrl: map[
                                      cartItems.imageName[index]],
                                      fit: BoxFit.cover,
                                      width: screenWidth * 0.3,
                                      height: screenHeight * 0.2,
                                    ),
                                    Expanded(
                                      child: Container(
                                        //color: Colors.red,
                                        child: Column(
                                          children: [
                                            Align(
                                              alignment:
                                              Alignment.centerLeft,
                                              child: Text(
                                                cartItems?.name[index],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                              Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  cartItems?.color[index],
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment:
                                              Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                  top: 5.0,
                                                ),
                                                child: Text(
                                                  "₱${cartItems?.currentPrice[index]}",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                //counter
                                                Container(
                                                  width: screenWidth * 0.05,
                                                  height:
                                                  screenWidth * 0.05,
                                                  child: Align(
                                                    alignment:
                                                    Alignment.center,
                                                    child: Text(
                                                      "${cartItems?.itemsQuantity[index]}",
                                                      style:
                                                      const TextStyle(
                                                          color: Colors
                                                              .white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: index ==
                                    (cartItems!.currentPrice.length - 1)
                                    ? (MediaQuery.of(context).size.height) *
                                    0.24
                                    : 0,
                              ),
                            ],
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: textColor,
                      ),
                    );
                  }
                }),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //top container
                Container(
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
                //address
                InkWell(
                  onTap: () {
                    openScreen(context, AddressScreen());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    padding: const EdgeInsets.only(
                        top: 10, right: 15, bottom: 10, left: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          FontAwesomeIcons.addressBook,
                          color: textColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(right: 20),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Name",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "09917377455",
                                      style: TextStyle(
                                          color: Colors.white.withAlpha(200),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "adddrreeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeesssssssssssssssssss",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Icon(
                          FontAwesomeIcons.angleRight,
                          color: textColor,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
