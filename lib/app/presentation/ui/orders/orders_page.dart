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
      Uri.parse('$baseUrl/cart'),
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
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 30, bottom: 20),
          child: Text(
            'Мои заказы',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Список заказов',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : cart == null
                      ? Center(child: Text('No data'))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            var order = cart['productDtos'][index];
                            return Container(
                              margin: EdgeInsets.only(bottom: 16.0),
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Заказ #1',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text('Статус: В ожидании',style: TextStyle(
                                      fontSize: 17.0,
                                    ),),
                                  Text('Статус оплаты: оплачено',style: TextStyle(
                                      fontSize: 17.0,
                                    ),),
                                  Text('День заказа: 10.06.2024 01:22',style: TextStyle(
                                      fontSize: 17.0,
                                    ),),
                                  Text('День доставки: 12.06.2024',style: TextStyle(
                                      fontSize: 17.0,
                                    ),),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Сумма заказа: 3250.00',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 156, 255, 7), // Other color you prefer
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ],
          ),
        ),
      ],
    ),
  );
}
}