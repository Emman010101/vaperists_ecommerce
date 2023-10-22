import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/data/global_vars.dart';
import 'package:vaperists_ecommerce/data/ids.dart';
import 'package:vaperists_ecommerce/utils/close_screen.dart';
import 'package:vaperists_ecommerce/utils/snackbar.dart';
import 'package:vaperists_ecommerce/widgets/firebase_image.dart';
import '../data/bnc_data.dart';
import '../data/firestore_crud.dart';
import '../utils/colors.dart';
import '../utils/internet_checker.dart';
import '../widgets/quantity_counter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BuyAndCartBottomSheetWidget extends StatefulWidget {
  var imageUrl, name, currentPrice, btnText;

  BuyAndCartBottomSheetWidget(
      {Key? key, this.imageUrl, this.name, this.currentPrice, this.btnText})
      : super(key: key);

  @override
  State<BuyAndCartBottomSheetWidget> createState() =>
      _BuyAndCartBottomSheetWidgetState();
}

class _BuyAndCartBottomSheetWidgetState
    extends State<BuyAndCartBottomSheetWidget> {
  List<Color> colors = [];
  int selectedIndex = 0;
  int itemCount = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(var i = 0;i < buyAndCartName.length;i++) {
      i == 0 ? colors.add(selectedItemColor) : colors.add(unselectedItemColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return buyAndCartBottomSheetLayout();
  }

  Widget buyAndCartBottomSheetLayout() {
    //print(map.toString());
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //item image container
            Container(
              //color: Colors.white,
              margin: EdgeInsets.only(left: 40, top: 30),
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: textColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: CachedNetworkImage(
                  imageUrl: map[buyAndCartImageName[selectedIndex]],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 40, top: 20, bottom: 20),
              child: const Text(
                "Color",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            //container of the color selector widget
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: ListView.builder(
                itemCount: buyAndCartImageName.length,
                itemBuilder: (context, index) {
                  return ProductColors(
                      buyAndCartImageName[index],
                      buyAndCartName,
                      buyAndCartCurrentPrice[index],
                      index,
                      buyAndCartColor[index],
                      index == 0 ? true : false,
                      index == buyAndCartImageName.length - 1 ? true : false);
                },
              ),
            ),
          ],
        ),
        //buy now and add to cart button
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(textColor),
              // shape: MaterialStateProperty.all(
              //   RoundedRectangleBorder(
              //     // Change your radius here
              //     borderRadius: BorderRadius.circular(16),
              //   ),
              // ),
            ),
            onPressed: () async{
              //print('Btn Text ${widget.btnText}');\
              isConnectedToInternet(context);
              // if(await isConnectedToInternet() == true) {
                if (widget.btnText.toString() == "Add To Cart") {
                  await addToCart(
                    productId, selectedIndex, itemCount,
                    FirebaseAuth.instance.currentUser!.uid);
                }
                    closeScreen(context);
              // }else{
              //   snackBar(context, 'Please check your internet connection.');
              // }
                //print('productId ${productId} selectedIndex ${selectedIndex} gItemCount ${gItemCount}');
            },
            child: Text(
              widget.btnText,
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
  //color selector
  Widget ProductColors(String imageName, String name, String currentPrice,
      int index, String color, bool firstItem, bool lastItem) {
    return Wrap(
      children: [
        firstItem
            ? const SizedBox(
                height: 10,
              )
            : const SizedBox(),
        GestureDetector(
          onTap: () {
            setState(() {
              for (var i = 0; i < colors.length; i++) {
                colors[i] = unselectedItemColor;
              }
              colors[index] = selectedItemColor;
              selectedIndex = index;
              itemCount = 1;
              gItemCount = itemCount;
            });
          },
          child: Container(
            //color: colors[index],
            margin: EdgeInsets.only(
                bottom: lastItem == true ? 15 : 5, left: 20, right: 20),
            // height: MediaQuery.of(context).size.height * 0.1,
            decoration: BoxDecoration(
              border: Border.all(color: colors[index]),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    FirebaseImage(
                      fileName: imageName,
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      name + " - " + color,
                      style: const TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: Text(
                        '₱$currentPrice',
                        style: const TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        lastItem == true
            ?  Padding(
                padding: const EdgeInsets.only(right: 0),
                child: quantityCounterWidget(),
              )
            : const SizedBox(),
        SizedBox(
          height:
              lastItem == true ? MediaQuery.of(context).size.height * 0.2 : 0,
        ),
      ],
    );
  }

  Widget quantityCounterWidget() {
    gItemCount = itemCount;
    return Container(
      color: textColor,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            child: const Text(
              'Quantity',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          //minus button
          TextButton(
            child: const Icon(
              FontAwesomeIcons.minus,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                if(itemCount <= 1) {
                  itemCount = 1;
                }else{
                  itemCount--;
                }
                gItemCount = itemCount;
              });
            },
          ),
          Text(itemCount.toString(),style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          //plus button
          TextButton(
            child: const Icon(
              FontAwesomeIcons.plus,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                itemCount++;
                gItemCount = itemCount;
              });
            },
          ),
        ],
      ),
    );
  }
}
