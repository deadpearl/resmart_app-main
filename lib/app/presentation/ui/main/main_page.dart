import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/cart/cart_page.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/motion_tab_bar.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/motion_tab_controller.dart';
import 'package:resmart/app/presentation/ui/home/home_page.dart';
import 'package:resmart/app/presentation/ui/orders/orders_page.dart';
import 'package:resmart/app/presentation/ui/profile/profile_page.dart';

class MainPage extends StatefulWidget {

  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPage();
  }
}

class _MainPage extends State<MainPage> with TickerProviderStateMixin {

  MotionTabBarController? _motionTabBarController;

  @override
  void initState() {
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: MaterialApp(
        home: Scaffold(
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _motionTabBarController,
            children: const <Widget>[
              HomePage(),
              OrdersPage(),
              CartPage(),
              ProfilePage()
            ],
          ),
          bottomNavigationBar: MotionTabBar(
            controller: _motionTabBarController,
            initialSelectedTab: "Главная",
            labels: const ["Главная", "Мои заказы", "Корзина", "Профиль"],
            iconPath: const ["assets/images/home.png", "assets/images/orders.png", "assets/images/cart.png", "assets/images/profile.png"],
            onTabItemSelected: (int value) {
              setState(() {
                _motionTabBarController!.index = value;
              });
            },
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }
}