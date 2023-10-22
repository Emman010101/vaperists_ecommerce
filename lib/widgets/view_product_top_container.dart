import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaperists_ecommerce/screens/cart_screen.dart';
import 'package:vaperists_ecommerce/screens/home_screen.dart';
import 'package:vaperists_ecommerce/utils/screen_opener.dart';
import '../utils/colors.dart';

class ViewProductTopContainer extends StatelessWidget {
  final String searchBarTitle;

  const ViewProductTopContainer({super.key, required this.searchBarTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //title
        Row(
          children: [
            BackButton(
              color: textColor,
              onPressed: () async {
                openScreen(context, const HomeScreen());
              },
            ),
            //search bar
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0),
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 15,
                  bottom: 15,
                ),
                decoration: BoxDecoration(
                  color: kGreyColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.magnifyingGlass,
                      size: 20,
                      color: textColor,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      searchBarTitle,
                      style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //const Spacer(),
            const SizedBox(
              width: 15,
            ),
            // Container(
            //   height: 40,
            //   width: 40,
            //   alignment: Alignment.center,
            //   child: Stack(
            //     children: [
            //       const Icon(
            //         FontAwesomeIcons.bell,
            //         color: textColor,
            //         size: 20,
            //       ),
            //       Positioned(
            //         right: 0,
            //         child: Container(
            //           height: 8,
            //           width: 8,
            //           decoration: const BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: kOrangeColor,
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            const SizedBox(
              width: 5,
            ),
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  // const Icon(
                  //   FontAwesomeIcons.cartShopping,
                  //   color: textColor,
                  //   size: 20,
                  // ),
                  IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.cartShopping,
                      color: textColor,
                      size: 20,
                    ),
                    iconSize: 50,
                    onPressed: () async {
                      openScreen(context, CartScreen(isFromViewProductScreen: true));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
