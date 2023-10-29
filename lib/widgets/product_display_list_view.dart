import 'package:flutter/gestures.dart';
import 'package:vaperists_ecommerce/data/firestore_crud.dart';
import 'package:vaperists_ecommerce/screens/view_product_screen.dart';
import 'package:vaperists_ecommerce/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vaperists_ecommerce/utils/loading.dart';
import 'package:vaperists_ecommerce/utils/screen_opener.dart';
import 'package:vaperists_ecommerce/widgets/firebase_image.dart';

class ProductDisplayWidget extends StatefulWidget {
  var collection;
  ProductDisplayWidget({super.key, this.collection});

  @override
  State<ProductDisplayWidget> createState() => _ProductDisplayWidgetState();
}

class _ProductDisplayWidgetState extends State<ProductDisplayWidget> {
  int clickedIndex = 0;
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return
      StreamBuilder<List<Products>>(
        stream: readProducts(widget.collection),
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          else if (snapshot.hasData) {
            final productsSnapshot = snapshot.data!;

            return MasonryGridView.count(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              crossAxisSpacing: 15,
              crossAxisCount: 2,
              itemCount: productsSnapshot
                  .toList()
                  .length,
              mainAxisSpacing: 10,
              itemBuilder: (context, index) {
                return singleItemWidget(
                    productsSnapshot[index],
                    index == productsSnapshot.length - 1 ? true : false,
                    index,
                  );
              },
            );
          } else {
            return Loading(color: textColor,);
          }
        }
    );
  }

  // single item widget for each product
  Widget singleItemWidget(Products products, bool lastItem, int index) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          clickedIndex = index;
        });
        openScreen(context, ViewProduct(collection: widget.collection, productId: products.id,));
      },
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10.0),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(0),
                      child: FirebaseImage(fileName: products.imageName[0]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 10.0,
                      ),
                      child: Text(
                        products.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        children: [
                          Text(
                              "₱${products.currentPrice[0]}",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "₱${products.oldPrice[0]}",
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: kRedColor,
                              decorationThickness: 2,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Positioned(
              //   right: 5,
              //   top: 10,
              //   child: Container(
              //     height: 30,
              //     width: 30,
              //     decoration: const BoxDecoration(
              //       color: kBackgroundColor,
              //       shape: BoxShape.circle,
              //     ),
              //     alignment: Alignment.center,
              //     child: const Icon(
              //       // products.isLiked == true
              //       //     ? FontAwesomeIcons.solidHeart
              //       //     : FontAwesomeIcons.heart,
              //       FontAwesomeIcons.heart,
              //       size: 15,
              //       color: Colors.white,
              //     ),
              //   ),
              // )
            ],
          ),
          SizedBox(
            height:
            lastItem == true ? (MediaQuery
                .of(context)
                .size
                .height) * 0.12 : 0,
          ),
        ],
      ),
    );
  }
}

