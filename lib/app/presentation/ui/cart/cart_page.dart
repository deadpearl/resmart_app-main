import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/model/Product.dart';
import 'package:resmart/app/presentation/model/Shop.dart';
import 'package:resmart/app/presentation/ui/create_order/pickup_page.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/drop_down_selector.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_button.dart';
import 'package:resmart/app/presentation/ui/product/product_list_item.dart';
import 'package:resmart/app/presentation/ui/product/product_page.dart';
import 'package:resmart/app/presentation/ui/shop/shop_products_page.dart';

class CartPage extends StatefulWidget {

  const CartPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CartPage();
  }
}

class _CartPage extends State<CartPage> {

  void _order() {
    NavigationUtils.push(context, const PickupPage());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.background,
      body: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                margin: const EdgeInsets.only(top: AppSize.topMargin),
                child: Stack(
                  children: [
                    const Center(
                      child: HeaderText("Корзина"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 16, top: 6),
                      child: Row(
                        children: [
                          Expanded(child: Container()),
                          InkWell(
                            onTap: () {
                              _order();
                            },
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                              child: const Text(
                                'Заказать',
                                style: TextStyle(
                                    color: AppColor.primary,
                                    fontFamily: 'Rubik',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
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
              _generateInCart(size),
              Container(
                margin: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, bottom: 20),
                child: PrimaryButton("Заказать", () { _order(); }),
              )
            ],
          )
      ),
    );
  }

  Widget _generateInCart(Size size) {
    return Column(
      children: [
        _generateShopInCart(size, Shop(), [Product(), Product(), Product()]),
        _generateShopInCart(size, Shop(), [Product(), Product(), Product()]),
      ],
    );
  }

  Widget _generateShopInCart(Size size, Shop shop, List<Product> products) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 14),
          padding: const EdgeInsets.only(left: AppSize.horizontal, right: 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderText(shop.name, size: 18),
                    Container(
                      width: size.width / 2,
                      color: AppColor.primary,
                      height: 1,
                      margin: const EdgeInsets.only(top: 12),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  NavigationUtils.push(context, ShopProductsPage(shop: shop));
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: [
                      const Text(
                        "Магазин",
                        style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Rubik'
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 6),
                        child: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColor.primary,
                          size: 18,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 16, bottom: 14),
          height: 258,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal - 14),
              children: _generateInShopProducts(size, products),
            ),
          )
        )
      ],
    );
  }

  List<Widget> _generateInShopProducts(Size size, List<Product> products) {
    var itemWidth = (size.width - AppSize.horizontal * 2 - 14) / 2;
    List<Widget> productWidgets = [];
    for (int i = 0; i < products.length; i++) {
      productWidgets.add(
        Container(
          width: itemWidth,
          margin: const EdgeInsets.only(right: 14),
          child: ProductListItem(products[i], onPressed: () {
            NavigationUtils.push(context, ProductPage(product: products[i]));
          }),
        )
      );
    }
    return productWidgets;
  }

}