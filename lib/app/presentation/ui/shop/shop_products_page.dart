import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/model/Product.dart';
import 'package:resmart/app/presentation/model/Shop.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/back_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/search_text_field.dart';
import 'package:resmart/app/presentation/ui/product/product_list_item.dart';
import 'package:resmart/app/presentation/ui/product/product_page.dart';
import 'package:resmart/app/presentation/ui/shop/shop_page.dart';

class ShopProductsPage extends StatefulWidget {

  final Shop shop;
  const ShopProductsPage({super.key, required this.shop});

  @override
  State<StatefulWidget> createState() {
    return _ShopProductsPage();
  }
}

class _ShopProductsPage extends State<ShopProductsPage> {

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColor.background,
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
                        margin: const EdgeInsets.only(left: 16, right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ButtonBack(() {
                              Navigator.of(context).pop();
                            }),
                            Expanded(child: Container()),
                            InkWell(
                              onTap: () {
                                NavigationUtils.push(context, ShopPage(shop: widget.shop));
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: const Text(
                                  "О магазине",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColor.primary,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.normal
                                  ),
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
                  margin: const EdgeInsets.only(top: 8, bottom: 18, left: AppSize.horizontal, right: AppSize.horizontal),
                  child: SearchTextField(
                    hint: "Продукт",
                    controller: _searchController,
                    action: TextInputAction.done,
                  ),
                ),
                _generatePopularProducts(size)
              ],
            )
        ),
      ),
    );
  }

  Widget _generatePopularProducts(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: AppSize.horizontal, bottom: 15, top: 30),
          child: const Text(
            "Популярные товары",
            style: TextStyle(
                color: AppColor.text,
                fontSize: 14,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.normal
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.horizontal),
          child: _generateProducts(size),
        )
      ],
    );
  }

  Widget _generateProducts(Size size) {
    var itemWidth = (size.width - AppSize.horizontal * 2 - 14) / 2;
    List<Widget> productWidgets = [];
    for (int i = 0; i < 6; i += 2) {
      productWidgets.add(
          Row(
            children: [
              Container(
                width: itemWidth,
                margin: const EdgeInsets.only(right: 7, bottom: 14),
                child: ProductListItem(Product(), onPressed: () {
                  NavigationUtils.push(context, ProductPage(product: Product()));
                }),
              ),
              Container(
                width: itemWidth,
                margin: const EdgeInsets.only(left: 7, bottom: 14),
                child: ProductListItem(Product(), onPressed: () {
                  NavigationUtils.push(context, ProductPage(product: Product()));
                }),
              )
            ],
          )
      );
    }
    return Column(children: productWidgets);
  }
}