import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/empty_content.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';

class OrdersPage extends StatefulWidget {

  const OrdersPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OrdersPage();
  }
}

class _OrdersPage extends State<OrdersPage> {

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