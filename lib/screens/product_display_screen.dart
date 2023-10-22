import 'package:vaperists_ecommerce/data/global_vars.dart';
import 'package:vaperists_ecommerce/utils/colors.dart';
import 'package:vaperists_ecommerce/widgets/product_display_list_view.dart';
import 'package:vaperists_ecommerce/widgets/top_container.dart';
import 'package:flutter/material.dart';

class ProductDisplayScreen extends StatefulWidget {
  const ProductDisplayScreen({super.key});

  @override
  State<ProductDisplayScreen> createState() => _ProductDisplayScreenState();
}

class _ProductDisplayScreenState extends State<ProductDisplayScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: selectedCategoryValue);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const TopContainer(
          title: "Vaperists",
          searchBarTitle: "Search Product",
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
          child: Column(
              children: [
                const SizedBox(height: 10,),
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
                        "Pods",
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
                        "Pod Mods",
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
                        "Vape Pens",
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
                        "Vape Mods",
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
        ),
      ],
    );
  }
}
