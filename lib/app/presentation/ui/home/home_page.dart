import 'package:flutter/material.dart';
import 'package:resmart/app/domain/provider/user_provider.dart';
import 'package:resmart/app/presentation/model/Product.dart';
import 'package:resmart/app/presentation/ui/city_selector/city_selector_page.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/search_text_field.dart';
import 'package:resmart/app/presentation/ui/product/product_list_item.dart';
import 'package:resmart/app/presentation/ui/product/product_page.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.background,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              margin: const EdgeInsets.only(top: AppSize.topMargin - 10, left: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      NavigationUtils.push(context, const CitySelectorPage());
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            UserProvider.defaultCity,
                            style: TextStyle(
                                color: AppColor.text,
                                fontFamily: 'Rubik',
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: AppColor.text,
                            size: 18,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(child: Container())
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.horizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HeaderText("Главная"),
                  Container(
                    margin: const EdgeInsets.only(top: 8, bottom: 18),
                    child: SearchTextField(
                      hint: "Магазин или продукт",
                      controller: _searchController,
                      action: TextInputAction.done,
                    ),
                  )
                ],
              ),
            ),
            _generatePopularProducts(size)
          ],
        )
      ),
    );
  }

  Widget _generatePopularProducts(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: AppSize.horizontal, bottom: 15),
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