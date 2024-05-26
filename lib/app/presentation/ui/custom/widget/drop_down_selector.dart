import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';

class DropDownSelector extends StatelessWidget {

  final List<String> items;
  final String selected;
  final Function? onSelected;

  const DropDownSelector({
    super.key,
    required this.items,
    required this.selected,
    required this.onSelected
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      value: selected,
      alignment: Alignment.centerLeft,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: const OutlineInputBorder(),
        hintText: selected,
        hintStyle: const TextStyle(
            color: Color.fromRGBO(194, 194, 194, 1)
        ),
        contentPadding: const EdgeInsets.only(right: 10, top: 14, bottom: 14),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.white
            ),
            borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.white
            ),
            borderRadius: BorderRadius.circular(10)
        ),
      ),
      hint: Text(
        selected,
        textAlign: TextAlign.start,
        style: const TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.6),
            fontFamily: 'Rubik',
            fontSize: 16,
            fontWeight: FontWeight.normal
        ),
      ),
      items: items.map((item) => DropdownMenuItem<String>(
        value: item,
        alignment: Alignment.centerLeft,
        child: Text(
          item,
          textAlign: TextAlign.start,
          style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Rubik',
              fontSize: 16,
              fontWeight: FontWeight.normal
          ),
        ),
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
}