import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/utils/colors.dart';
import 'package:vaperists_ecommerce/utils/loading.dart';
import '../bottom_sheets/buy_and_cart_bottom_sheet.dart';
import '../data/firestore_crud.dart';

class BnCWidget extends StatefulWidget {
  var collection;
  var btnText;
  var productId;
  BnCWidget({Key? key,this.collection, this.btnText, required this.productId}) : super(key: key);

  @override
  State<BnCWidget> createState() => _BnCWidgetState();
}

class _BnCWidgetState extends State<BnCWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Products?>(
        future: readProduct(widget.productId, widget.collection),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          } else if (snapshot.hasData) {
            final product = snapshot.data;
            return product == null
                ? const Center(
                    child: Text(
                      'No Products',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : BuyAndCartBottomSheetWidget(imageUrl: product.imageName,name: product.name, currentPrice: product.currentPrice, btnText: widget.btnText, productId: widget.productId,);
          } else {
            return Center(
              child: Loading(color: textColor,),
            );
          }
        });
  }
}
