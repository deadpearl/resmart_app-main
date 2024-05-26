import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/model/Shop.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/widget/back_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';

class ShopPage extends StatefulWidget {

  final Shop shop;

  const ShopPage({super.key, required this.shop});

  @override
  State<StatefulWidget> createState() {
    return _ShopPage();
  }
}

class _ShopPage extends State<ShopPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: AppSize.topMargin),
                  height: 40,
                  child: Stack(
                    children: [
                      Center(
                        child: HeaderText(widget.shop.name),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16, right: AppSize.horizontal),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ButtonBack(() {
                              Navigator.of(context).pop();
                            }),
                            Expanded(child: Container()),
                            const Icon(
                              Icons.star_rounded,
                              color: AppColor.primary,
                              size: 18,
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 4),
                              child: Text(
                                widget.shop.rating.toString().replaceAll(".", ","),
                                style: const TextStyle(
                                    color: AppColor.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Rubik'
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12, left: AppSize.horizontal, right: AppSize.horizontal),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(0.0, 5.0),
                        blurRadius: 30,
                        spreadRadius: 0,
                      )
                    ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.shop.images[0]
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 18, left: AppSize.horizontal, right: AppSize.horizontal),
                  child: Text(
                    widget.shop.address,
                    style: const TextStyle(
                        color: AppColor.text,
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Rubik'
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: AppSize.horizontal, right: AppSize.horizontal),
                  child: Text(
                    widget.shop.description,
                    style: const TextStyle(
                      color: AppColor.secondaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Rubik'
                    ),
                  ),
                )
              ],
            )
        ),
      ),
    );
  }

}