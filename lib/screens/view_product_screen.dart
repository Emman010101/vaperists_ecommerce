import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/utils/useralreadyloggedin_checker.dart';
import 'package:vaperists_ecommerce/widgets/bnc_widget.dart';
import 'package:vaperists_ecommerce/widgets/view_product_top_container.dart';
import 'package:vaperists_ecommerce/widgets/view_product_widget.dart';

import '../data/global_vars.dart';
import '../utils/colors.dart';
import '../utils/screen_opener.dart';
class ViewProduct extends StatefulWidget {
  var collection;
  ViewProduct({super.key,this.collection});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    map.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
             Column(
              children: [
                const ViewProductTopContainer(searchBarTitle: "Search Product"),
                Expanded(
                  child: SingleChildScrollView(
                    child: ViewProductWidget(collection: widget.collection),
                  ),
                ),
              ],
            ),
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
                        await userLoggedInChecker(context);
                        buyAndCartBtmSheet("Buy Now");
                      },
                      child: const Text(
                        "Buy Now",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
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
                        //await signOut();
                        //snackBar(context, 'signed out');
                        //await readUser(FirebaseAuth.instance.currentUser!.email);
                        //await addToCart('itemName', 'itemQuantity', FirebaseAuth.instance.currentUser!.email);
                        await userLoggedInChecker(context);
                        buyAndCartBtmSheet("Add To Cart");
                      },
                      child: const Text(
                        "Add To Cart",
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

  void buyAndCartBtmSheet(btnText){
    showModalBottomSheet(
        backgroundColor: appBgColor,
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        builder: (BuildContext bc) {
          return Wrap(
            children: [
              BnCWidget(collection: widget.collection, btnText: btnText,),
            ],
          );
        });
  }
}
