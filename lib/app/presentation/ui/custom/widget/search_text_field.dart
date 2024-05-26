import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';

class SearchTextField extends StatelessWidget {

  final String hint;
  final TextEditingController controller;
  final TextInputAction? action;
  final Function? onSubmitted;

  const SearchTextField({
    super.key,
    required this.hint,
    required this.controller,
    this.action,
    this.onSubmitted
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColor.border
        )
      ),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
      child: Row(
        children: [
          const SizedBox(
            width: 22,
            child: Icon(
              Icons.search_rounded,
              color: AppColor.secondaryText,
              size: 22,
            ),
          ),
          Expanded(
            child: TextFormField(
              autocorrect: false,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  color: AppColor.text,
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Rubik'
              ),
              onFieldSubmitted: (value) {
                onSubmitted?.call(value);
              },
              maxLength: 30,
              textInputAction: action,
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                counterText: "",
                fillColor: Colors.white,
                border: const OutlineInputBorder(),
                hintText: hint,
                hintStyle: const TextStyle(
                    color: AppColor.secondaryText
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none
              ),
            )
          )
        ],
      ),
    );
  }
}