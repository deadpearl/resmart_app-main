import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/empty_content.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/back_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_text_field.dart';

class ChangePasswordPage extends StatefulWidget {

  const ChangePasswordPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChangePasswordPage();
  }
}

class _ChangePasswordPage extends State<ChangePasswordPage> {

  final _passwordController = TextEditingController();
  final _confPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSize.horizontal),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: AppSize.topMargin),
                height: 40,
                child: Stack(
                  children: [
                    const Center(
                      child: HeaderText("Сменить пароль"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16, right: AppSize.horizontal),
                      child: ButtonBack(() {
                        Navigator.of(context).pop();
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: PrimaryTextField(
                  hint: "Новый пароль",
                  controller: _passwordController,
                  isPassword: true,
                  action: TextInputAction.next,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 14),
                child: PrimaryTextField(
                  hint: "Подтвердите пароль",
                  controller: _confPasswordController,
                  isPassword: true,
                  action: TextInputAction.done,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                child: PrimaryButton(
                  "Сменить",
                      () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}