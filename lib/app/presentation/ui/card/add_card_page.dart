import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/widget/back_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/description_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddCardPage extends StatefulWidget {

  const AddCardPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddCardPage();
  }
}

class _AddCardPage extends State<AddCardPage> {

  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _dateController = TextEditingController();
  final _cvvController = TextEditingController();

  void _saveCard() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ButtonBack(() {
              Navigator.of(context).pop();
            }, margins: const EdgeInsets.only(top: AppSize.topMargin, left: 16, bottom: 10)),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, bottom: AppSize.bottomMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderText("Платежная карта"),
                    Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 20),
                      child: const DescriptionText("Заполните поля ниже чтобы добавить платежную карту"),
                    ),
                    PrimaryTextField(
                      hint: "Название (как сохранить?)",
                      controller: _nameController,
                      action: TextInputAction.next,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 13, bottom: 13),
                      child: PrimaryTextField(
                        hint: "Номер карты",
                        controller: _numberController,
                        formatter: MaskTextInputFormatter(
                            mask: '#### #### #### ####',
                            filter: { "#": RegExp(r'[0-9]') },
                            type: MaskAutoCompletionType.lazy
                        ),
                        keyboardType: TextInputType.number,
                        action: TextInputAction.next,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 5),
                            child: PrimaryTextField(
                              hint: "12/26",
                              formatter: MaskTextInputFormatter(
                                  mask: '##/##',
                                  filter: { "#": RegExp(r'[0-9]') },
                                  type: MaskAutoCompletionType.lazy
                              ),
                              controller: _dateController,
                              keyboardType: TextInputType.number,
                              action: TextInputAction.next,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            child: PrimaryTextField(
                              hint: "CVV",
                              formatter: MaskTextInputFormatter(
                                  mask: '###',
                                  filter: { "#": RegExp(r'[0-9]') },
                                  type: MaskAutoCompletionType.lazy
                              ),
                              controller: _cvvController,
                              keyboardType: TextInputType.number,
                              action: TextInputAction.done,
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(child: Container()),
                    PrimaryButton(
                      "Сохранить", () { _saveCard(); }
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}