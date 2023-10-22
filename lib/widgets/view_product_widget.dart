import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/data/bnc_data.dart';
import 'package:vaperists_ecommerce/data/firestore_crud.dart';
import 'package:vaperists_ecommerce/data/ids.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaperists_ecommerce/widgets/firebase_image.dart';
import '../utils/colors.dart';

class ViewProductWidget extends StatefulWidget {
  var collection;
  ViewProductWidget({super.key,this.collection});

  @override
  State<ViewProductWidget> createState() => _ViewProductWidgetState();
}

class _ViewProductWidgetState extends State<ViewProductWidget> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Products?>(
        future: readProduct(productId, widget.collection),
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
                : productViewWidget(product.imageName, product.name,
                    product.currentPrice, product.oldPrice, product.color);
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: textColor,
              ),
            );
          }
        });
  }

  Widget productViewWidget(List<dynamic> imageName, String name, List<dynamic> currentPrice, List<dynamic> oldPrice, List<dynamic> color){

    buyAndCartImageName = imageName;
    buyAndCartName = name;
    buyAndCartCurrentPrice = currentPrice;
    buyAndCartOldPrice = oldPrice;
    buyAndCartColor = color;

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          padding: const EdgeInsets.only(bottom: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(1, 1),
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                  child: Image.asset('assets/images/smokebg.png'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: FirebaseImage(fileName: imageName[0]),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 10.0),
                    child: Row(
                      children: [
                        Text(
                          "₱${currentPrice[0]}",
                          style:
                              const TextStyle(color: textColor, fontSize: 20),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "₱${oldPrice[0]}",
                          style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: kRedColor,
                            decorationThickness: 2,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 10.0,
                    ),
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: textColor),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 10.0,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.yellow,
                          size: 10,
                        ),
                        const SizedBox(width: 3),
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.yellow,
                          size: 10,
                        ),
                        const SizedBox(width: 3),
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.yellow,
                          size: 10,
                        ),
                        const SizedBox(width: 3),
                        Icon(
                          FontAwesomeIcons.solidStar,
                          color: Colors.yellow,
                          size: 10,
                        ),
                        const SizedBox(width: 3),
                        Icon(
                          FontAwesomeIcons.star,
                          color: Colors.yellow,
                          size: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: Text(
                      """Description: 
    Lemon Lime from Elf Bar is a refreshing citrus fusion that’s bursting with zesty character. This e-liquid captures the bright tanginess of Lemon and the slightly sweet tartness of juicy Lime. It's a vibrant, clean vape that leaves a delightful zing on your taste buds.

    The Elf Bar 600 V2 refines everything that makes the original Elf Bar 600 such an iconic vaping device. The Elf Bar 600 V2 offers the same convenience and portability but with a smooth and shiny metallic skin, and the latest advances in disposable coil technology for even more intensely satisfying flavour.

    The Elf Bar 600 V2 disposable vape contains 2ml of 20mg strength nicotine salt e-liquid for near-instant relief from nicotine cravings. The bar is slim, lightweight and easy to travel with and delivers a crisp and tactile MTL (mouth-to-lung) vaping sensation in an astonishing variety flavours.

    The addition of QUAQ coil technology provides an even more intense flavour than the original Elf Bar 600. Using the Elf Bar 600 V2 is simplicity itself, there are no buttons to press, tanks to refill or coils to change – you simply remove the device from the packaging and enjoy delicious, satisfying vaping straight away. When your battery has depleted, the LED light will flash to inform you, then you simply replace the device with a new one.

    Disposable vape devices like the Elf Bar 600 V2 Disposable Vape are an ideal way for newer vapers to start enjoying vaping products and the safer, more rewarding alternative they offer over the harms of traditional cigarettes. The Elf Bar 600 V2 Disposable Vape is the perfect vape device to start your vaping journey with, while more experienced vapers will appreciate having a no-nonsense, fuss-free disposable vape bar as a handy substitute for their regular vape kit.

    Carry your Elf Bar 600 V2 Disposable Vape with you wherever you go and enjoy incredible flavour and fast relief from nicotine cravings with an effortlessly simple-to-use vape device that tastes amazing from the first puff to the last. """,
                      style: TextStyle(color: textColor),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.12,
        ),
      ],
    );
  }
}
