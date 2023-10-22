import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/data/firebase_auth.dart';
import 'package:vaperists_ecommerce/screens/cart_screen.dart';
import 'package:vaperists_ecommerce/screens/product_display_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/firestore_crud.dart';
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
  Color _iconButtonColor1 = textColor;
  Color _iconButtonColor2 = textColor.withOpacity(0.5);
  Color _iconButtonColor3 = textColor.withOpacity(0.5);

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
                });
              },
              children: [
                const ProductDisplayScreen(),
                CartScreen(isFromViewProductScreen: false),
                //TODO do the cart bro
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
                    // ...tabBarIcons.map(
                    //   (icon) => IconButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         _iconButtonColor = Colors.yellow;
                    //       });
                    //       if (icon == FontAwesomeIcons.house) {
                    //         pageController.jumpToPage(0);
                    //         print('Icon $icon');
                    //       } else {
                    //         pageController.jumpToPage(1);
                    //         print('Icon $icon');
                    //       }
                    //     },
                    //     icon: Icon(icon,color: _iconButtonColor, size: 22),
                    //   ),
                    // ),
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
                          _iconButtonColor1 = textColor;
                          _iconButtonColor2 = textColor.withOpacity(0.5);
                          _iconButtonColor3 = textColor.withOpacity(0.5);
                        });
                        pageController.jumpToPage(0);
                      },
                      icon: Icon(tabBarIcons[0],
                          color: _iconButtonColor1, size: 22),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _iconButtonColor1 = textColor.withOpacity(0.5);
                          _iconButtonColor2 = textColor;
                          _iconButtonColor3 = textColor.withOpacity(0.5);
                        });
                        pageController.jumpToPage(1);
                      },
                      icon: Icon(tabBarIcons[1],
                          color: _iconButtonColor2, size: 22),
                    ),
                    IconButton(
                      onPressed: () {
                        //deleteAllProducts("pods");
                        signOut(context);
                        setState(() {
                          _iconButtonColor1 = textColor.withOpacity(0.5);
                          _iconButtonColor2 = textColor.withOpacity(0.5);
                          _iconButtonColor3 = textColor;
                        });
                        pageController.jumpToPage(0);
                      },
                      icon: Icon(tabBarIcons[2],
                          color: _iconButtonColor3, size: 22),
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
