import 'dart:async';

import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/authorization/authorization_page.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/outlined_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/secondary_button.dart';
import 'package:resmart/app/presentation/ui/register/register_page.dart';

class SplashPage extends StatefulWidget {

  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashPage();
  }
}

class _SplashPage extends State<SplashPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: AppColor.primary,
          body: Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 40),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Image.asset(
                        "assets/images/logo.png"
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: SecondaryButton(
                    text: "Войти",
                    onPressed: () {
                      NavigationUtils.push(context, const AuthorizationPage());
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: AppOutlinedButton(
                    text: "Зарегистрироваться",
                    onPressed: () {
                      NavigationUtils.push(context, const RegisterPage());
                    },
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}