import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaperists_ecommerce/data/global_vars.dart';
import 'package:vaperists_ecommerce/utils/colors.dart';

class QuantityCounter extends StatefulWidget {
  const QuantityCounter({Key? key}) : super(key: key);

  @override
  State<QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  int itemCount = 1;
  @override
  Widget build(BuildContext context) {
    return quantityCounterWidget();
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
              });
            },
          ),
        ],
      ),
    );
  }
}
