import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resmart/app/domain/provider/api.dart';
import 'package:resmart/app/domain/provider/user_provider.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/button_icon.dart';
import 'package:resmart/app/presentation/ui/custom/widget/description_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_text_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_text_field.dart';
import 'package:resmart/app/presentation/ui/main/main_page.dart';

class AuthorizationPage extends StatefulWidget {

  const AuthorizationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthorizationPage();
  }
}

class _AuthorizationPage extends State<AuthorizationPage> {
 final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserProvider _userProvider = UserProvider();
  void _startPage(Widget widget) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
      return widget;
    }), (route) => false);
  }

  void _changePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MainPage()),
    );
  }

Future<void> _login() async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _emailController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      if (token != null) {
        await _userProvider.setAuthToken(token); // Сохраняем токен через UserProvider
        _changePage(); // Перенаправляем на главную страницу
      } else {
        // Обработка ошибки: токен не был получен
        print('Ошибка: токен не был получен');
      }
    } else {
      // Обработка ошибки: неверные учетные данные или другая ошибка
      print('Ошибка: ${response.statusCode}');
    }
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
                      const HeaderText("Войти"),
                      const DescriptionText("Введите почту и пароль чтобы войти"),
                      Container(
                        margin: const EdgeInsets.only(top: 24, bottom: 14),
                        child: PrimaryTextField(
                          hint: "Ваша почта",
                          controller: _emailController,
                          action: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: PrimaryTextField(
                          hint: "Ваш пароль",
                          controller: _passwordController,
                          isPassword: true,
                          action: TextInputAction.done,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 100),
                        child: const PrimaryTextButton(
                          name: "Забыли пароль?",
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  
                  child: ElevatedButton(
                  onPressed: _login,
                  child: const Text("Войти"),
                ),
                ),
              ],
            ),
          ),
        )
    );
  }
}