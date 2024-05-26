import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/main/main_page.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CreateOrderPage extends StatefulWidget {

  const CreateOrderPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateOrderPage();
  }
}

class _CreateOrderPage extends State<CreateOrderPage> {

  void _cancelOrder() {
    NavigationUtils.put(context, const MainPage());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, top: AppSize.topMargin, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HeaderText("Заказ №24231"),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: CircularPercentIndicator(
                    radius: 80.0,
                    lineWidth: 10.0,
                    percent: 0.75,
                    backgroundColor: Colors.transparent,
                    center: const Text(
                      "75%",
                      style: TextStyle(
                          color: AppColor.primary,
                          fontSize: 30,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w700
                      ),
                    ),
                    progressColor: AppColor.primary.withOpacity(0.5),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 22, bottom: 50),
                child: Text(
                  "Создание заказа...",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 16,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),
              InkWell(
                  onTap: () {
                    _cancelOrder();
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      border: Border.all(color: AppColor.primary)
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      alignment: Alignment.center,
                      child: const Text(
                        "Отменить",
                        style: TextStyle(
                            color: AppColor.primary,
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}