import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/model/Product.dart';
import 'package:resmart/app/presentation/model/ProductShop.dart';
import 'package:resmart/app/presentation/model/Shop.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/widget/back_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/shop/product_shop_list_item.dart';

class ProductPage extends StatefulWidget {

  final Product product;

  const ProductPage({super.key, required this.product});

  @override
  State<StatefulWidget> createState() {
    return _ProductPage();
  }
}

class _ProductPage extends State<ProductPage> {

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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            HeaderText(widget.product.name),
                            Container(
                              margin: const EdgeInsets.only(left: 5, top: 6),
                              child: Text(
                                widget.product.size,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 14,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.normal
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        child: ButtonBack(() {
                          Navigator.of(context).pop();
                        }),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12, left: AppSize.horizontal, right: AppSize.horizontal),
                  padding: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                        widget.product.image
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: AppSize.horizontal, right: 200, bottom: 20),
                  color: AppColor.primary,
                  height: 1,
                ),
                ProductShopListItem(ProductShop(shop: Shop())),
                ProductShopListItem(ProductShop(shop: Shop())),
                ProductShopListItem(ProductShop(shop: Shop())),
                ProductShopListItem(ProductShop(shop: Shop())),
                ProductShopListItem(ProductShop(shop: Shop())),
              ],
            )
        ),
      ),
    );
  }

}