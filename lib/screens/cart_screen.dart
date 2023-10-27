import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/data/firestore_crud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaperists_ecommerce/data/global_vars.dart';
import 'package:vaperists_ecommerce/screens/checkout_screen.dart';
import 'package:vaperists_ecommerce/utils/screen_opener.dart';
import 'package:vaperists_ecommerce/widgets/firebase_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../utils/close_screen.dart';
import '../utils/colors.dart';

class CartScreen extends StatefulWidget {
  bool isFromViewProductScreen;

  CartScreen({Key? key, required this.isFromViewProductScreen})
      : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var uid = FirebaseAuth.instance.currentUser!.uid;
  List<dynamic> isItemChecked = [];
  List<dynamic> pricesArr = [];
  List<dynamic> quantityArr = [];
  bool isCheckAll = false;
  double subTotal = 0.00;
  double shippingFee = 0.00;
  double lastItemSizedBoxSize = 0.24;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    Map<String, List<dynamic>> cartItemsMap = {};
    lastItemSizedBoxSize = 0.24;
    pricesArr = [];
    quantityArr = [];

    if (widget.isFromViewProductScreen) lastItemSizedBoxSize = 0.12;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      body: SafeArea(
        child: Stack(
          children: [
            FutureBuilder<FinalCartItems?>(
                future: readCart(uid),
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

                    if (isItemChecked.length > cartItems!.itemsId.length)
                      isItemChecked.clear();

                    if (isItemChecked.isEmpty) {
                      //populate isChecked list
                      for (var i = 0; i < cartItems!.itemsId.length; i++) {
                        isItemChecked.add(false);
                      }
                    }

                    //setting this values for the map, using this for
                    cartItemsMap['collection'] = cartItems!.collection;
                    cartItemsMap['itemsId'] = cartItems!.itemsId;
                    cartItemsMap['itemsQuantity'] = cartItems!.itemsQuantity;
                    cartItemsMap['selectedItemIndex'] =
                        cartItems!.selectedItemIndex;

                    pricesArr = cartItems.currentPrice;
                    quantityArr = cartItems.itemsQuantity;

                    return cartItems.collection.isEmpty
                        ? const Center(
                            child: Text(
                              'Your cart is empty',
                              style: TextStyle(color: textColor),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: cartItems.currentPrice.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: [
                                  SizedBox(
                                    height: index == 0
                                        ? (MediaQuery.of(context).size.height) *
                                            0.12
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
                                        Checkbox(
                                          checkColor: Colors.black,
                                          activeColor: textColor,
                                          value: isItemChecked[index],
                                          onChanged: (bool? value) {
                                            setState(() {
                                              isItemChecked[index] = value!;
                                              calculate(cartItems.currentPrice,
                                                  cartItems.itemsQuantity);
                                            });
                                          },
                                        ),
                                        map.isEmpty ||
                                                cartItems.imageName.length >
                                                    map.length
                                            ? FirebaseImage(
                                                fileName:
                                                    cartItems.imageName[index],
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
                                                    cartItems.name[index],
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
                                                      cartItems.color[index],
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
                                                      "₱${cartItems.currentPrice[index]}",
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    //minus button
                                                    SizedBox(
                                                      width: screenWidth * 0.05,
                                                      height:
                                                          screenWidth * 0.05,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          setState(() {

                                                              cartItems
                                                                  .itemsQuantity[
                                                              index]--;
                                                              if(cartItems.itemsQuantity[index] < 1){
                                                                cartItems.itemsQuantity[index] = 1;
                                                              }
                                                              calculate(
                                                                  cartItems
                                                                      .currentPrice,
                                                                  cartItems
                                                                      .itemsQuantity);
                                                          });

                                                          await updateCart(
                                                              uid, cartItems);
                                                        },
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      textColor),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        5),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        5),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .minus,
                                                          color: Colors.black,
                                                          size: screenWidth *
                                                              0.04,
                                                        ),
                                                      ),
                                                    ),
                                                    //counter
                                                    Container(
                                                      width: screenWidth * 0.05,
                                                      height:
                                                          screenWidth * 0.05,
                                                      child: Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          "${cartItems.itemsQuantity[index]}",
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                    ),
                                                    //plus button
                                                    SizedBox(
                                                      width: screenWidth * 0.05,
                                                      height:
                                                          screenWidth * 0.05,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            cartItems
                                                                    .itemsQuantity[
                                                                index]++;
                                                            calculate(
                                                                cartItems
                                                                    .currentPrice,
                                                                cartItems
                                                                    .itemsQuantity);
                                                          });
                                                          await updateCart(
                                                              uid, cartItems);
                                                        },
                                                        style: ButtonStyle(
                                                          padding:
                                                              MaterialStateProperty
                                                                  .all(EdgeInsets
                                                                      .zero),
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all<Color>(
                                                                      textColor),
                                                          shape: MaterialStateProperty
                                                              .all<
                                                                  RoundedRectangleBorder>(
                                                            const RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        5),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            5),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          FontAwesomeIcons.plus,
                                                          color: Colors.black,
                                                          size: screenWidth *
                                                              0.04,
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
                                            (cartItems.currentPrice.length - 1)
                                        ? (MediaQuery.of(context).size.height) *
                                            lastItemSizedBoxSize
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
            //top container
            Container(
              padding: const EdgeInsets.only(
                  top: 10, right: 15, bottom: 10, left: 15),
              color: kBackgroundColor,
              height: screenHeight * 0.1,
              child: Row(
                children: [
                  widget.isFromViewProductScreen
                      ? BackButton(
                          color: textColor,
                          onPressed: () async {
                            closeScreen(context);
                          },
                        )
                      : const SizedBox(),
                  //title
                  const Text(
                    "Cart",
                    style: TextStyle(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.trashCan,
                      color: textColor,
                      size: 20,
                    ),
                    iconSize: 50,
                    onPressed: () async {
                      await deleteItemInCart(
                          FirebaseAuth.instance.currentUser!.uid,
                          cartItemsMap,
                          isItemChecked);
                      setState(() {
                        subTotal = 0.00;
                        isCheckAll = false;
                      });
                    },
                  ),
                ],
              ),
            ),
            //checkout
            Positioned(
              bottom: widget.isFromViewProductScreen ? 0 : screenHeight * 0.1,
              child: Container(
                padding: const EdgeInsets.all(15),
                width: screenWidth,
                color: productWidgetBg,
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.black,
                      activeColor: textColor,
                      value: isCheckAll,
                      onChanged: (bool? value) {
                        setState(() {
                          isCheckAll = value!;
                          for (int i = 0; i < isItemChecked.length; i++) {
                            if (value) {
                              isItemChecked[i] = true;
                            } else {
                              isItemChecked[i] = false;
                            }
                          }
                          calculate(pricesArr, quantityArr);
                        });
                      },
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(
                          "Subtotal: $subTotal",
                          style: const TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Shipping fee: $shippingFee",
                          style: const TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
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
                      onPressed: () async {
                        if(subTotal > 0.0){
                          openScreen(context, CheckoutScreen(isItemChecked: isItemChecked, total: subTotal,));
                        }
                      },
                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
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

  void calculate(prices, quantity) {
    subTotal = 0;
    for (int i = 0; i < isItemChecked.length; i++) {
      if (isItemChecked[i]) {
        subTotal += (int.parse(prices[i]) * quantity[i]);
      }
    }
  }
}
