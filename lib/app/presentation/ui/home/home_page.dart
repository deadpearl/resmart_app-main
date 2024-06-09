import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:resmart/app/domain/provider/api.dart';
import 'package:resmart/app/domain/provider/user_provider.dart';
import 'package:resmart/app/presentation/model/Product.dart';
import 'package:resmart/app/presentation/ui/cart/cart_page.dart';
import 'package:resmart/app/presentation/ui/city_selector/city_selector_page.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/search_text_field.dart';
import 'package:resmart/app/presentation/ui/orders/orders_page.dart';
import 'package:resmart/app/presentation/ui/product/product_list_item.dart';
import 'package:resmart/app/presentation/ui/product/product_page.dart';
import 'package:http/http.dart' as http;
import 'package:resmart/app/presentation/ui/profile/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom/navigation/motion_tab_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class Category {
  final String name;
  final String imageUrl;

  Category({required this.name, required this.imageUrl});
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> _futureProducts;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProducts();
  }

  final List<Map<String, String>> categories = [
    {'name': 'Овощи', 'imageUrl': 'assets/images/1.jpg'},
    {'name': 'Напитки', 'imageUrl': 'assets/images/2.jpg'},
    {'name': 'Хоз товары', 'imageUrl': 'assets/images/3.jpg'},
    {'name': 'Алкогольные Напитки', 'imageUrl': 'assets/images/4.jpeg'},
    {'name': 'Сырная', 'imageUrl': 'assets/images/5.jpeg'},
    {'name': 'Молочные', 'imageUrl': 'assets/images/6.jpg'},
  ];

  Future<List<dynamic>> fetchProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    print('token $token');
    final response = await http.get(
      Uri.parse('$baseUrl/products'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print(responseBody);
      return jsonDecode(responseBody);
    } else {
      throw Exception('Failed to load products');
    }
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
                margin: const EdgeInsets.only(
                    top: AppSize.topMargin - 10, left: 16),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        NavigationUtils.push(context, const CitySelectorPage());
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              UserProvider.defaultCity,
                              style: TextStyle(
                                  color: AppColor.text,
                                  fontFamily: 'Rubik',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSize.horizontal),
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
              Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 250,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: categories.map((category) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              left: 5.0, top: 5.0, right: 5.0, bottom: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "${category['imageUrl']!}",
                                fit: BoxFit.cover,
                                height: 100, // Fixed height for the image
                                width: double.infinity,
                              ),
                              SizedBox(height: 10),
                              Text(
                                category['name']!,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // Обработка нажатия кнопки
                                },
                                child: Text('Перейти'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: FutureBuilder<List<dynamic>>(
                  future: _futureProducts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No products found'));
                    }

                    return SingleChildScrollView(
                      child: _generateProducts(context, snapshot.data!),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            category.imageUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Text(
            category.name,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Здесь можно добавить навигацию на нужный экран
            },
            child: Text('Перейти'),
          ),
        ],
      ),
    );
  }
}

Widget _generateProducts(BuildContext context, List<dynamic> products) {
  Size size = MediaQuery.of(context).size;
  var itemWidth = (size.width - 54) / 2;
  var itemHeight = itemWidth * 1.4; // Adjust the height as needed

  List<Widget> productWidgets = [];
  for (int i = 0; i < products.length; i += 2) {
    productWidgets.add(
      Row(
        children: [
          Container(
            width: itemWidth,
            margin: const EdgeInsets.only(right: 7, top: 10, bottom: 14),
            child: _buildProductItemContainer(
                context, products[i], itemWidth, itemHeight),
          ),
          if (i + 1 < products.length)
            Container(
              width: itemWidth,
              margin: const EdgeInsets.only(left: 7, bottom: 14),
              child: _buildProductItemContainer(
                  context, products[i + 1], itemWidth, itemHeight),
            ),
        ],
      ),
    );
  }
  return Column(children: productWidgets);
}

Widget _buildProductItemContainer(
    BuildContext context, dynamic product, double width, double height) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetailPage(product: product)),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: height,
            child: _buildProductItem(context, product),
          ),
        ],
      ),
    ),
  );
}

Widget _buildProductItem(BuildContext context, dynamic product) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          product['imageUrl'],
          fit: BoxFit.cover,
          height: 120, // Fixed height for the image
          width: double.infinity, // Full width of the container
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          product['name'],
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          "${product['price'].toStringAsFixed(2)} тг",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ),
    ],
  );
}

class ProductDetailPage extends StatelessWidget {
  final dynamic product;

  ProductDetailPage({required this.product});

  void addToCard(BuildContext context) async {
    var profileinfo = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print('token $token');
    final responseProfile = await http.get(
      Uri.parse('$baseUrl/my'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (responseProfile.statusCode == 200) {
      String responseBody = utf8.decode(responseProfile.bodyBytes);
      print(responseBody);
      profileinfo = jsonDecode(responseBody);
    } else {
      throw Exception('Failed to load profile');
    }

    Map<String, dynamic> orderData = {
      'totalPrice': product['price'],
      'restaurant': profileinfo['id'],
      'orderItems': [
        {
          'totalPrice': product['price'], // Используйте актуальные данные
          'price': product['price'],
          'quantity': 1, // Установите нужное количество
          'product': {
            'id': product['id'],
            'reviews': [],
          },
          'orderDate': '2024-06-09', // Установите нужную дату
          'deliveryDate': '2024-06-11', // Установите нужную дату
          'payWay': 5, // Или 6, выберите подходящий способ оплаты
          'supplier': {
            'id': profileinfo['id'],
          },
        }
      ],
    };

    print(product);

    final response = await http.post(
      Uri.parse('$baseUrl/cart/add'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(orderData),
    );

    if (response.statusCode == 200) {
         showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Успешно'),
          content: Text('Заказ добавлен успешно!'),
          actions: <Widget>[
            TextButton(
              child: Text('ОК'),
              onPressed: () {
                Navigator.of(context).pop(); // Закрыть попап
              },
            ),
          ],
        );
      },
    );
      print('Order added successfully');
    } else {
      print('Failed to add order');
      print('Status code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFavorite = false;
    return Scaffold(
      appBar: AppBar(
        title: Text('Продукты'),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12, left: 16.0, right: 16.0),
            padding: const EdgeInsets.only(right: 50, left: 50, top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product['imageUrl'],
                width: 100,
                height: 300,
              ),
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 35, bottom: 20),
                      width: 50,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                          print('Favorite status: $isFavorite');
                        },
                        iconSize: 24.0, // Размер иконки
                        padding: EdgeInsets.all(8.0), // Отступы внутри кнопки
                        constraints: BoxConstraints(
                          minHeight: 48.0,
                          minWidth: 48.0,
                        ),
                        // Фон кнопки с помощью BoxDecoration
                        splashRadius: 24.0,
                        splashColor: Colors.red.withOpacity(0.2),
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300], // Цвет фона кнопки
                      ),
                    ),
                  ],
                );
              })),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    "${product['name']}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Rubik',
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 40),
                  child: Text(
                    "${product['category']}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Rubik',
                      fontSize: 18,
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 40, top: 20),
                  child: Text(
                    "${product['price']}₸",
                    style: const TextStyle(
                      color: AppColor.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Rubik',
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  width: 270,
                  child: ElevatedButton(
                    onPressed: () {
                      addToCard(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 90, 121, 99),
                      foregroundColor:
                          Colors.white, // Серый цвет для первой кнопки
                    ),
                    child: Text('Добавить в корзину'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _cartButton() {
    return SizedBox(
      height: 30,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(5),
        child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          decoration: BoxDecoration(
              color: AppColor.primary, borderRadius: BorderRadius.circular(5)),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
                size: 14,
              ),
              Text(
                "  В корзину",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: 'Rubik',
                    fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
      ),
    );
  }
}
