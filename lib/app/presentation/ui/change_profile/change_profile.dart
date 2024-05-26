import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/empty_content.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/back_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_text_field.dart';

class ChangeProfilePage extends StatefulWidget {

  const ChangeProfilePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChangeProfilePage();
  }
}

class _ChangeProfilePage extends State<ChangeProfilePage> {

  final _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
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
                  controller: _usernameController,
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
        )
      ),
    );
  }
}