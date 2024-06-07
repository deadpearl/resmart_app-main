import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/empty_content.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/back_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_text_field.dart';

import 'dart:convert';

import 'package:resmart/app/domain/provider/api.dart';
import 'package:resmart/app/presentation/ui/change_password/change_password.dart';
import 'package:resmart/app/presentation/ui/change_profile/change_profile.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/feedback/feedback_page.dart';
import 'package:resmart/app/presentation/ui/splash/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ChangeProfilePage extends StatefulWidget {

  const ChangeProfilePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChangeProfilePage();
  }
}

class _ChangeProfilePage extends State<ChangeProfilePage> {

  final _usernameController = TextEditingController();
var profileinfo;
  final _searchController = TextEditingController();
  bool _isLoading = true; // Переменная для отслеживания состояния загрузки

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

 Future<void> fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    print('token $token');
    final response = await http.get(
      Uri.parse('$baseUrl/my'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      String responseBody = utf8.decode(response.bodyBytes);
      print(responseBody);
      setState(() {
        profileinfo = jsonDecode(responseBody);
        _isLoading = false; // Завершаем загрузку после получения данных
      });
    } else {
      setState(() {
        _isLoading = false; // Завершаем загрузку даже в случае ошибки
      });
      throw Exception('Failed to load profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: _isLoading 
        ? Center(child: CircularProgressIndicator()) // Показ индикатора загрузки
        : profileinfo != null ? Container(
          padding: const EdgeInsets.only(left: AppSize.horizontal,  right: AppSize.horizontal),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: AppSize.topMargin),
                height: 40,
                child: Stack(
                  children: [
                    const Center(
                      child: HeaderText("Изменить профиль"),
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
                  hint: "Имя пользователя",
                  controller: TextEditingController(text: profileinfo['name']),
                  action: TextInputAction.done,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: PrimaryTextField(
                  hint: "Никнейм",
                  controller: TextEditingController(text: profileinfo['username']),
                  action: TextInputAction.done,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: PrimaryTextField(
                  hint: "Эмейл",
                   controller: TextEditingController(text: profileinfo['email']),
                  action: TextInputAction.done,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: PrimaryTextField(
                  hint: "Номер Телефона",
                   controller: TextEditingController(text: profileinfo['phone']),
                  action: TextInputAction.done,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: PrimaryTextField(
                  hint: "Адрес",
                   controller: TextEditingController(text: profileinfo['address']),
                  action: TextInputAction.done,
                ),
              ),
             
              Expanded(
                child: Container(),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                child: PrimaryButton(
                  "Сохранить",
                      () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ) : Center(child: Text('Не удалось загрузить профиль. Пожалуйста, попробуйте еще раз.')),
      ),
    );
  }
}