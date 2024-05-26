import 'package:flutter/material.dart';
import 'package:resmart/app/domain/provider/user_provider.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/widget/search_text_field.dart';
import 'package:resmart/app/presentation/ui/custom/widget/back_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';

class CitySelectorPage extends StatefulWidget {

  const CitySelectorPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CitySelectorPage();
  }
}

class _CitySelectorPage extends State<CitySelectorPage> {

  final UserProvider _userProvider = UserProvider();
  final _searchController = TextEditingController();
  final _cityList = ["Алматы", "Астана", "Атырау", "Актау", "Талдыкорган", "Шымкент"];
  String _selectedCity = UserProvider.defaultCity;

  @override
  void initState() {
     super.initState();
     _userProvider.getSelectedCity().then((value) => {
       setState(() {
       _selectedCity = UserProvider.defaultCity;
       })
     });
  }

  Future<void> _setSelectedCity(String city) {
    return _userProvider.setSelectedCity(city);
  }

  void _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColor.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              margin: const EdgeInsets.only(top: AppSize.topMargin, left: 16, right: 16),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: const HeaderText("Города"),
                  ),
                  ButtonBack(() {
                    _onBackPressed();
                  })
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, top: 10, bottom: 2),
              child: SearchTextField(
                hint: "Поиск...",
                controller: _searchController,
                action: TextInputAction.done
              ),
            ),
            if (_selectedCity != null) Expanded(
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  children: [
                    _generateList()
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _generateList() {
    List<Widget> children = [];
    for (int i = 0; i < _cityList.length; i++) {
      children.add(
        _cityItem(
          _cityList[i],
          _cityList[i] == _selectedCity,
          () {
            _onBackPressed();
          }
        )
      );
    }
    return Column(children: children);
  }

  Widget _cityItem(String name, bool isSelected, Function onSelected) {
    return InkWell(
      onTap: () {
        onSelected.call();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: AppSize.horizontal),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 16,
                  )
              ],
            ),
          ),
          Container(
            height: 1,
            color: Colors.black.withOpacity(0.1),
          )
        ],
      ),
    );
  }
}