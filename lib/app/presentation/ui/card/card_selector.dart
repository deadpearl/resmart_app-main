import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/model/Card.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';

class CardSelector extends StatelessWidget {

  final List<PayCard> cards;
  final Function? onSelected;
  final int selected;

  const CardSelector({
    super.key,
    required this.cards,
    required this.onSelected,
    required this.selected
  });

  @override
  Widget build(BuildContext context) {
    List<int> items = [];
    for (int i = 0; i < cards.length; i++) {
      items.add(i);
    }
    return DropdownButtonFormField2<int>(
      isExpanded: true,
      value: selected,
      alignment: Alignment.centerLeft,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(),
        hintText: "Выберите карту",
        hintStyle: const TextStyle(
            color: Color.fromRGBO(194, 194, 194, 1)
        ),
        contentPadding: const EdgeInsets.only(right: 10, top: 14, bottom: 14),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black.withOpacity(0.2)
            ),
            borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black.withOpacity(0.2)
            ),
            borderRadius: BorderRadius.circular(10)
        ),
      ),
      hint: const Text(
        "Выберите карту",
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.6),
            fontFamily: 'Rubik',
            fontSize: 16,
            fontWeight: FontWeight.normal
        ),
      ),
      items: items.map((item) => DropdownMenuItem<int>(
        value: item,
        alignment: Alignment.centerLeft,
        child: cards[item].type == "add" ? const Text(
          "Добавить карту",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.normal
          ),
        ) : _createCardView(cards[item]),
      )).toList(),
      onChanged: (value) {
        onSelected?.call(value);
      },
      onSaved: (value) {
        onSelected?.call(value);
      },
      buttonStyleData: const ButtonStyleData(
        decoration: BoxDecoration(
            color: Colors.white
        ),
        padding: EdgeInsets.only(right: 0, left: 10),
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColor.primary,
        ),
        iconSize: 24,
      ),
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  Widget _createCardView(PayCard card) {
    return Row(
      children: [
        Image.asset(
          card.type == "master" ? "assets/images/master.png" : "assets/images/visa.png",
          height: 14,
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            card.name,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.normal
            ),
          ),
        ),
        Text(
          card.number,
          style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 16,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.normal
          ),
        ),
      ],
    );
  }
}