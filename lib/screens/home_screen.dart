import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/data/firebase_auth.dart';
import 'package:vaperists_ecommerce/screens/account_screen.dart';
import 'package:vaperists_ecommerce/screens/cart_screen.dart';
import 'package:vaperists_ecommerce/screens/product_display_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final pageController = PageController(initialPage: 0);
  final _iconButtonColor = <Color>[textColor,textColor.withOpacity(0.5),textColor.withOpacity(0.5)];

  //tabbar icons
  final tabBarIcons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.cartShopping,
    FontAwesomeIcons.user,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      print(FirebaseAuth.instance.currentUser!.email);
    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              top: 50,
              child: Image.asset('assets/images/smokebg.png'),
            ),
            PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                  for(var i = 0; i < _iconButtonColor.length;i++){
                    if(i == index){
                      _iconButtonColor[i] = textColor;
                    }else{
                      _iconButtonColor[i] = textColor.withOpacity(0.5);
                    }
                  }
                });
              },
              //screens of navbar
              children: [
                const ProductDisplayScreen(),
                CartScreen(isFromViewProductScreen: false),
                const AccountScreen(),
              ],
            ),
            //bottombar
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                height: 70,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.circular(0.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        // createProducts(
                        //     name: "Smok Nfix Pro",
                        //     imageName:
                        //         "https://firebasestorage.googleapis.com/v0/b/vaperists-4bdff.appspot.com/o/products_images%2Fsmoknfixpro-removebg-preview.png?alt=media&token=01c3e8a6-625e-42b9-920a-c3e1f6129167",
                        //     currentPrice: "1500",
                        //     oldPrice: "2000",
                        //     isLiked: true,
                        //     collection: "pods",
                        // color: "black"
                        // );
                        setState(() {
                          _iconButtonColor[0] = textColor;
                          _iconButtonColor[1] = textColor.withOpacity(0.5);
                          _iconButtonColor[2] = textColor.withOpacity(0.5);
                        });
                        pageController.jumpToPage(0);
                      },
                      icon: Icon(tabBarIcons[0],
                          color: _iconButtonColor[0], size: 22),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _iconButtonColor[0] = textColor.withOpacity(0.5);
                          _iconButtonColor[1] = textColor;
                          _iconButtonColor[2] = textColor.withOpacity(0.5);
                        });
                        pageController.jumpToPage(1);
                      },
                      icon: Icon(tabBarIcons[1],
                          color: _iconButtonColor[1], size: 22),
                    ),
                    IconButton(
                      onPressed: () {
                        //deleteAllProducts("pods");
                        //signOut(context);
                        setState(() {
                          _iconButtonColor[0] = textColor.withOpacity(0.5);
                          _iconButtonColor[1] = textColor.withOpacity(0.5);
                          _iconButtonColor[2] = textColor;
                        });
                        pageController.jumpToPage(2);
                      },
                      icon: Icon(tabBarIcons[2],
                          color: _iconButtonColor[2], size: 22),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
