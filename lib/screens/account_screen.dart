import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vaperists_ecommerce/widgets/account_screen_tabbar.dart';
import '../utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                //user
                Container(
                  padding: const EdgeInsets.all(20),
                  color: productWidgetBg,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: CachedNetworkImage(
                          imageUrl:
                          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fG1lbiUyMHBob3RvfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 15,),
                      const Text("John Doe", style: TextStyle(fontSize: 25, color: Colors.white),),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.gear,
                          color: textColor,
                          size: 20,
                        ),
                        iconSize: 20,
                        onPressed: () {
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Icon(FontAwesomeIcons.box, color: textColor,size: 25,),
                          Text("To ship", style: TextStyle(color: textColor),)
                        ],
                      ),
                      Column(
                        children: [
                          Icon(FontAwesomeIcons.truck, color: textColor,size: 25,),
                          Text("To receive", style: TextStyle(color: textColor),)
                        ],
                      ),
                      Column(
                        children: [
                          Icon(FontAwesomeIcons.solidComment, color: textColor,size: 25,),
                          Text("To review", style: TextStyle(color: textColor),)
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
