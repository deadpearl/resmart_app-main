import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/home/home_page.dart';
import 'package:resmart/app/presentation/ui/main/main_page.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CreateOrderPageState();
  }
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  double _percentComplete = 0.75;
  bool _isOrderCreated = false;

  @override
  void initState() {
    super.initState();
    // Start a timer to simulate the progress completion
    Timer(Duration(seconds: 4), () {
      setState(() {
        _percentComplete = 1.0;
        _isOrderCreated = true;
      });
    });
  }

  void _cancelOrOrderAgain() {
    if (_isOrderCreated) {
      NavigationUtils.put(context,  HomePage());
      // Handle ordering again
    } else {
      // Handle canceling order
      NavigationUtils.put(context,  HomePage());
    }
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
                    percent: _percentComplete,
                    backgroundColor: Colors.transparent,
                    center: Text(
                      "${(_percentComplete * 100).toInt()}%",
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
                  _isOrderCreated ? "Создан" : "Создание заказа...",
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
                    _cancelOrOrderAgain();
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
                      child: Text(
                        _isOrderCreated ? "Заказать еще" : "Отменить",
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