import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/utils/colors.dart';
import 'package:vaperists_ecommerce/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopContainer extends StatelessWidget {
  final String title;
  final String searchBarTitle;

  const TopContainer(
      {super.key, required this.title, required this.searchBarTitle});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        //title
        Container(
          padding: const EdgeInsets.only(top: 10, right: 15, bottom: 10, left: 15),
          color: kBackgroundColor,
          height: screenHeight * 0.1,
          child: Row(
            children: [
              Text(
                title,
                style: kNormalStyle.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              const SizedBox(width: 15,),
              // search bar
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: kGreyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 20,
                        color: textColor,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        searchBarTitle,
                        style: const TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
