import 'package:flutter/material.dart';
import 'package:resmart/app/domain/provider/api.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartPage extends StatefulWidget {

  const CartPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CartPage();
  }
}

class _CartPage extends State<CartPage> {

  var cart; 
  bool _isLoading = true; 
    @override
  void initState() {
    super.initState();
    fetchCart();
  }

 Future<void> fetchCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    print('token $token');
    final response = await http.get(
      Uri.parse('$baseUrl/cart'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response);

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print('CART');
      print(responseBody);
      setState(() {
        cart = jsonDecode(responseBody);
        _isLoading = false; // Завершаем загрузку после получения данных
      });
    } else {
      setState(() {
        _isLoading = false; // Завершаем загрузку даже в случае ошибки
      });
      throw Exception('Failed to load profile');
    }
  }

double calculateTotalPrice() {
  if (cart != null && cart['productDtos'] != null) {
    double totalPrice = 0.0;
    for (var productDto in cart['productDtos']) {
      totalPrice += productDto['totalPrice'];
    }
    return totalPrice;
  } else {
    return 0.0;
  }
}
 
  void _order() {
    NavigationUtils.push(context,  PickupPage(totalPrice: calculateTotalPrice()));
  }

@override
Widget build(BuildContext context) {
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
            margin: const EdgeInsets.only(right: AppSize.horizontal, left: AppSize.horizontal, top: 50),
            padding: const EdgeInsets.all(10),
            child: Text(
              'Список продуктов',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
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
          Container(
  margin: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, bottom: 20),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: _isLoading
        ? [Center(child: CircularProgressIndicator())] // Отображение индикатора загрузки, пока данные загружаются
        : cart != null && cart['productDtos'] != null
            ? cart['productDtos'].map<Widget>((productDto) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  
                  child: Column(
                  
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                       
                      SizedBox(
                        height: 100, // Фиксированная высота изображения
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            productDto['orderItems'][0]['product']['imageUrl'],
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        productDto['orderItems'][0]['product']['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Количество: ${productDto['orderItems'][0]['quantity']}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Цена: ${productDto['orderItems'][0]['price']}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Общая цена: ${productDto['totalPrice']}',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList()
            : [Text('Нет товаров в корзине')],
  ),
),
 Container(
            margin: const EdgeInsets.symmetric(horizontal: AppSize.horizontal, vertical: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'Общая цена всех товаров: ${calculateTotalPrice()}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, bottom: 20),
            child: PrimaryButton("Заказать", () { _order(); }),
          )
        ],
      )
    ),
  );
}
}