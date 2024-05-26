import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/model/Card.dart';
import 'package:resmart/app/presentation/ui/card/add_card_page.dart';
import 'package:resmart/app/presentation/ui/card/card_selector.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/navigation_utils.dart';
import 'package:resmart/app/presentation/ui/custom/widget/back_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/description_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';
import 'package:resmart/app/presentation/ui/custom/widget/primary_button.dart';
import 'package:resmart/app/presentation/ui/orders/create_order_page.dart';

class PickupPage extends StatefulWidget {

  const PickupPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PickupPage();
  }
}

class _PickupPage extends State<PickupPage> {

  var _pay = false;
  var _selectedCard = 1;

  void _startAddCard() {
    NavigationUtils.push(context, const AddCardPage());
  }

  void _createOrder() {
    NavigationUtils.put(context, const CreateOrderPage());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                padding: const EdgeInsets.only(left: AppSize.horizontal, right: AppSize.horizontal, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderText("Доставка"),
                    Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 20),
                      child: const DescriptionText("Введите адрес куда доставить и наш курьер доставит по вашему адресу в ближайшее время."),
                    ),
                    Expanded(child: Container()),
                    const HeaderText("Стоимость", size: 18),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: const Row(
                        children: [
                          DescriptionText("Итоговая цена"),
                          Expanded(
                            child: Text(
                              "20,000₸",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'Rubik'
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: const Row(
                        children: [
                          DescriptionText("Комиссия"),
                          Expanded(
                            child: Text(
                              "800₸",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: AppColor.primary,
                                  fontSize: 16,
                                  fontFamily: 'Rubik'
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 14),
                      width: size.width / 2,
                      color: AppColor.primary,
                      height: 1,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8, bottom: 20),
                      child: const Row(
                        children: [
                          DescriptionText("Итого"),
                          Expanded(
                            child: Text(
                              "20,800₸",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: AppColor.primary,
                                fontSize: 20,
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith((states) => AppColor.primary),
                            value: _pay,
                            side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(width: 1.0, color: AppColor.primary)),
                            onChanged: (bool? value) {
                              setState(() {
                                _pay = value!;
                              });
                            },
                          ),
                        ),
                        const Text(
                          "  Оплатить в приложении",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.normal
                          ),
                        ),
                      ],
                    ),
                    if (_pay)
                      Container(
                        margin: const EdgeInsets.only(top: 14),
                        child: CardSelector(
                            cards: [
                              PayCard(type: "add"),
                              PayCard(),
                              PayCard(type: "visa", number: "*1254")
                            ],
                            selected: _selectedCard,
                            onSelected: (value) {
                              setState(() {
                                _selectedCard = value;
                              });
                              if (value == 0) {
                                _startAddCard();
                              }
                            }
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: PrimaryButton("Заказать", () { _createOrder(); }),
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