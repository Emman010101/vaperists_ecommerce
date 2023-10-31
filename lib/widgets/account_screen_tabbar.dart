import 'package:flutter/material.dart';
import 'package:vaperists_ecommerce/widgets/product_display_list_view.dart';

import '../data/global_vars.dart';
import '../utils/colors.dart';

class AccountScreenTabBar extends StatefulWidget {
  const AccountScreenTabBar({super.key});

  @override
  State<AccountScreenTabBar> createState() => _AccountScreenTabBarState();
}

class _AccountScreenTabBarState extends State<AccountScreenTabBar>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 4, vsync: this, initialIndex: selectedCategoryValue);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.only(top: (MediaQuery.of(context).size.height * 0.1)+20),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          // tab bar and tab views
          TabBar(
            controller: tabController,
            indicatorColor: Colors.transparent,
            labelColor: textColor,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            onTap: (value) {
              setState(() {
                selectedCategoryValue = value;
              });
              tabController.animateTo(value);
            },
            tabs: [
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // color: selectedValue == 0
                    //     ? kBackgroundColor
                    //     : kGreyColor.withOpacity(0.8),
                    color: kBackgroundColor,
                    boxShadow: selectedCategoryValue == 0
                        ? [
                            BoxShadow(
                                color: textColor.withOpacity(0.0),
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(0, 1))
                          ]
                        : null),
                child: const Text(
                  "To ship",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // color: selectedValue == 1
                    //     ? kBackgroundColor
                    //     : kGreyColor.withOpacity(0.8),
                    color: kBackgroundColor,
                    boxShadow: selectedCategoryValue == 1
                        ? [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(0, 1))
                          ]
                        : null),
                child: const Text(
                  "To Receive",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // color: selectedValue == 0
                    //     ? kBackgroundColor
                    //     : kGreyColor.withOpacity(0.8),
                    color: kBackgroundColor,
                    boxShadow: selectedCategoryValue == 2
                        ? [
                            BoxShadow(
                                color: textColor.withOpacity(0.0),
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(0, 1))
                          ]
                        : null),
                child: const Text(
                  "To Review",
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // color: selectedValue == 0
                    //     ? kBackgroundColor
                    //     : kGreyColor.withOpacity(0.8),
                    color: kBackgroundColor,
                    boxShadow: selectedCategoryValue == 3
                        ? [
                            BoxShadow(
                                color: textColor.withOpacity(0.0),
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: const Offset(0, 1))
                          ]
                        : null),
                child: const Text(
                  "Returns & Cancellations",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),

          // tab view
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                ProductDisplayWidget(collection: "pods"),
                ProductDisplayWidget(collection: "pod_mods"),
                ProductDisplayWidget(collection: "pods"),
                ProductDisplayWidget(collection: "pods"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
