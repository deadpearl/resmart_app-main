import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/empty_content.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/domain/provider/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrdersPage extends StatefulWidget {

  const OrdersPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrdersPage();
  }
}

class _OrdersPage extends State<OrdersPage> {

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
      Uri.parse('$baseUrl/orders'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    print(response);

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print('ORDERS');
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




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          padding: const EdgeInsets.only(left: 0, right: 0, top: AppSize.topMargin),
          children: const [
            Center(
              child: HeaderText("Мои заказы"),
            ),
            EmptyContentWidget()
          ],
        )
      ),
    );
  }
}