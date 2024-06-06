import 'dart:convert';

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


class _HomePageState extends State<HomePage> {
 late Future<List<dynamic>> _futureProducts;
  final _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProducts();
  }

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
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    Scaffold(
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child:  FutureBuilder<List<dynamic>>(
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
        )
      ),
      //    bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   onTap: (int index) {
      //     // Вызываем функцию _onItemTapped и передаем в нее индекс выбранного элемента
      //     _onItemTapped(index);
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding:
      //             EdgeInsets.only(top: 14.0), // Увеличиваем отступ по вертикали
      //         child: Image(
      //           image: AssetImage('assets/images/home.png'),
      //           height: 24, // Задаем высоту иконки
      //         ),
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: EdgeInsets.symmetric(
      //             vertical: 12.0), // Увеличиваем отступ по вертикали
      //         child: Image(
      //           image: AssetImage('assets/images/orders.png'),
      //           height: 24, // Задаем высоту иконки
      //         ),
      //       ),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: EdgeInsets.symmetric(
      //             vertical: 12.0), // Увеличиваем отступ по вертикали
      //         child: Image(
      //           image: AssetImage('assets/images/cart.png'),
      //           height: 30, // Задаем высоту иконки
      //         ),
      //       ),
      //       label: 'Notifications',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: EdgeInsets.symmetric(
      //             vertical: 12.0), // Увеличиваем отступ по вертикали
      //         child: Image(
      //           image: AssetImage('assets/images/profile.png'),
      //           height: 24, // Задаем высоту иконки
      //         ),
      //       ),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }
  // void _onItemTapped(int index) {
  //   print(index);
  //   switch (index) {
  //     case 0:
  //       print('NEWS:');
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => HomePage()));
  //       // Обработка нажатия на элемент "News"
  //       // Навигация на соответствующую страницу или выполнение действия
  //       break;
  //     case 1:
  //       print('FIRE:');
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) => OrdersPage()));
  //       // Обработка нажатия на элемент "Search"
  //       // Навигация на соответствующую страницу или выполнение действия
  //       break;
  //     case 2:
  //       print('NOTIFICATIONS:');
  //       Navigator.pushReplacement(context,
  //           MaterialPageRoute(builder: (context) => CartPage()));
  //       // Обработка нажатия на элемент "Notifications"
  //       // Навигация на соответствующую страницу или выполнение действия
  //       break;
  //     case 3:
  //       print('PROFILE:');
  //       Navigator.pushReplacement(
  //           context, MaterialPageRoute(builder: (context) => ProfilePage()));
  //       // Обработка нажатия на элемент "Profile"
  //       // Навигация на соответствующую страницу или выполнение действия
  //       break;
  //     default:
  //       break;
  //   }
  // }
  }

Widget _generateProducts(BuildContext context, List<dynamic> products) {
  Size size = MediaQuery.of(context).size;
  var itemWidth = (size.width - 54) / 2;
  var itemHeight = itemWidth * 1.6; // Adjust the height as needed

  List<Widget> productWidgets = [];
  for (int i = 0; i < products.length; i += 2) {
    productWidgets.add(
      Row(
        children: [
          Container(
            width: itemWidth,
            margin: const EdgeInsets.only(right: 7, bottom: 14),
            child: _buildProductItemContainer(context, products[i], itemWidth, itemHeight),
          ),
          if (i + 1 < products.length)
            Container(
              width: itemWidth,
              margin: const EdgeInsets.only(left: 7, bottom: 14),
              child: _buildProductItemContainer(context, products[i + 1], itemWidth, itemHeight),
            ),
        ],
      ),
    );
  }
  return Column(children: productWidgets);
}

Widget _buildProductItemContainer(BuildContext context, dynamic product, double width, double height) {
  return Container(
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


  // Widget _buildProductItem(BuildContext context, dynamic product) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => ProductDetailPage(product: product),
  //         ),
  //       );
  //     },
  //     child: Column(
  //       children: [
  //         Image.network(product['imageUrl']),
  //         Text(product['name']),
  //         Text(product['size'] ?? ''),
  //         Text('${product['price']}'),
  //       ],
  //     ),
  //   );
  // }
class ProductDetailPage extends StatelessWidget {
  final dynamic product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            height: 40,
            child: Stack(
              children: [
                Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(product['name'], style: TextStyle(fontSize: 24)),
                      Container(
                        margin: const EdgeInsets.only(left: 5, top: 6),
                        child: Text(
                          product['size'] ?? '',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 16),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12, left: 16.0, right: 16.0),
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(product['imageUrl']),
            ),
          ),
        ],
      ),
    );
  }
}
