import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/button_icon.dart';
import 'package:resmart/app/presentation/ui/custom/widget/description_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_text_field.dart';
import 'package:resmart/app/presentation/ui/main/main_page.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RegisterPage();
  }
}

class _RegisterPage extends State<RegisterPage> {

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _startPage(Widget widget) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }), (route) => false);
  }

  void _changePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 40, top: 60),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ButtonIcon(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onClick: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeaderText("Регистрация"),
                      const DescriptionText("Заполните все поля ниже"),
                      Container(
                        margin: const EdgeInsets.only(top: 24, bottom: 14),
                        child: PrimaryTextField(
                          hint: "Имя",
                          controller: _nameController,
                          action: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        child: PrimaryTextField(
                          hint: "Ваша почта",
                          controller: _emailController,
                          action: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 100),
                        child: PrimaryTextField(
                          hint: "Ваш пароль",
                          controller: _passwordController,
                          isPassword: true,
                          action: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  child: PrimaryButton(
                    "Войти",
                    () {
                      NavigationUtils.put(context, const MainPage());
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}