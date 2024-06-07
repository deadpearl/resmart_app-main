import 'dart:convert';

import 'package:flutter/material.dart';
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


class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfilePage();
  }
}

class _ProfilePage extends State<ProfilePage> {
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
    return Scaffold(
      backgroundColor: AppColor.background,
        body: _isLoading 
        ? Center(child: CircularProgressIndicator()) // Показ индикатора загрузки
        : profileinfo != null ?
      
      Container(
        padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, top: AppSize.topMargin, bottom: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const HeaderText("Профиль"),
            Container(
              margin: const EdgeInsets.only(top: 20, bottom: 16),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromRGBO(83, 156, 101, 1),
                  )
              ),
              child: const Icon(
                Icons.person,
                size: 50,
                color: Color.fromRGBO(83, 156, 101, 1),
              ),
            ),
             Text(
              '${profileinfo['username']}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Rubik'
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  NavigationUtils.push(context, const ChangeProfilePage());
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size:18,
                        ),
                      ),
                      Text(
                        "Изменить профиль",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  NavigationUtils.push(context, const FeedBackPage());
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(
                          Icons.star,
                          color: Colors.white,
                          size:18,
                        ),
                      ),
                      Text(
                        "Отзывы",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  NavigationUtils.push(context, const ChangePasswordPage());
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(
                          Icons.password,
                          color: Colors.white,
                          size:18,
                        ),
                      ),
                      Text(
                        "Сменить пароль",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {

                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(
                          Icons.info_outlined,
                          color: Colors.white,
                          size:18,
                        ),
                      ),
                      Text(
                        "Информация",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

 Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  NavigationUtils.push(context, const FeedBackPage());
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(
                          Icons.adf_scanner_outlined,
                          color: Colors.white,
                          size:18,
                        ),
                      ),
                      Text(
                        "Способ оплаты",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

             Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  NavigationUtils.push(context, const FeedBackPage());
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(
                          Icons.approval_outlined,
                          color: Colors.white,
                          size:18,
                        ),
                      ),
                      Text(
                        "Избранное",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

             Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  NavigationUtils.push(context, const FeedBackPage());
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: AppColor.primary,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(
                          Icons.language,
                          color: Colors.white,
                          size:18,
                        ),
                      ),
                      Text(
                        "Язык",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Expanded(child: Container()),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  NavigationUtils.put(context, const SplashPage());
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(217, 116, 116, 1.0),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: const Icon(
                          Icons.logout_rounded,
                          color: Colors.white,
                          size:18,
                        ),
                      ),
                      Text(
                        "Выйти",
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ) : Center(child: Text('Не удалось загрузить профиль. Пожалуйста, попробуйте еще раз.')),
    );
  }
}