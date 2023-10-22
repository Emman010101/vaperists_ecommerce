// import 'package:flutter/material.dart';
// import 'package:vaperists_ecommerce/data/bnc_data.dart';
// import 'package:vaperists_ecommerce/widgets/firebase_image.dart';
// import 'package:vaperists_ecommerce/widgets/quantity_counter.dart';
// import '../utils/colors.dart';
//
// class BuyAndCartColorSelector extends StatefulWidget {
//   BuyAndCartColorSelector({Key? key}) : super(key: key);
//
//   @override
//   State<BuyAndCartColorSelector> createState() =>
//       _BuyAndCartColorSelectorState();
// }
//
// class _BuyAndCartColorSelectorState extends State<BuyAndCartColorSelector> {
//   List<Color> colors = [
//     selectedItemColor,
//     unselectedItemColor,
//     unselectedItemColor,
//     unselectedItemColor,
//     unselectedItemColor,
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: buyAncCartImageName.length,
//       itemBuilder: (context, index) {
//         return ProductColors(
//             buyAncCartImageName[index],
//             buyAndCartName,
//             buyAndCartCurrentPrice[index],
//             index,
//             buyAndCartColor[index],
//             index == 0 ? true : false,
//             index == buyAncCartImageName.length - 1 ? true : false);
//       },
//     );
//   }
//
//   Widget ProductColors(String imageName, String name, String currentPrice,
//       int index, String color, bool firstItem, bool lastItem) {
//     return Wrap(
//       children: [
//         firstItem
//             ? const SizedBox(
//                 height: 10,
//               )
//             : const SizedBox(),
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               for (var i = 0; i < colors.length; i++) {
//                 colors[i] = unselectedItemColor;
//               }
//               colors[index] = selectedItemColor;
//             });
//           },
//           child: Container(
//             //color: colors[index],
//             margin: EdgeInsets.only(
//                 bottom: lastItem == true ? 15 : 5, left: 20, right: 20),
//             // height: MediaQuery.of(context).size.height * 0.1,
//             decoration: BoxDecoration(
//               border: Border.all(color: colors[index]),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     FirebaseImage(
//                       fileName: imageName,
//                       width: MediaQuery.of(context).size.width * 0.2,
//                       height: MediaQuery.of(context).size.height * 0.1,
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       name + " - " + color,
//                       style: const TextStyle(
//                           color: textColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15),
//                     ),
//                     const Spacer(),
//                     Container(
//                       margin: const EdgeInsets.only(right: 20),
//                       child: Text(
//                         '₱$currentPrice',
//                         style: const TextStyle(
//                             color: textColor,
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         lastItem == true
//             ? const Padding(
//                 padding: EdgeInsets.only(right: 0),
//                 child: QuantityCounter(),
//               )
//             : const SizedBox(),
//         SizedBox(
//           height:
//               lastItem == true ? MediaQuery.of(context).size.height * 0.2 : 0,
//         ),
//       ],
//     );
//   }
// }
