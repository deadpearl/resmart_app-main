import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';

class PrimaryTextField extends StatelessWidget {

  final String hint;
  final TextInputFormatter? formatter;
  final TextEditingController controller;
  final TextInputAction action;
  final TextInputType keyboardType;
  final Function? onSubmitted;
  final bool? isPassword;
  final int maxLines;
  final int maxLength;
  final TextAlign textAlign;

  const PrimaryTextField({
    super.key,
    required this.hint,
    this.formatter,
    required this.controller,
    this.action = TextInputAction.done,
    this.keyboardType = TextInputType.text,
    this.onSubmitted,
    this.isPassword,
    this.maxLines = 1,
    this.maxLength = 30,
    this.textAlign = TextAlign.start
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      inputFormatters: formatter == null ? null : [formatter!],
      obscureText: isPassword == null ? false : true,
      autocorrect: false,
      maxLines: maxLines,
      textAlign: textAlign,
      style: const TextStyle(
        color: AppColor.text,
        fontSize: 15,
        fontWeight: FontWeight.normal,
        fontFamily: 'Rubik'
      ),
      onFieldSubmitted: (value) {
        onSubmitted?.call(value);
      },
      maxLength: maxLength,
      textInputAction: action,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        counterText: "",
        fillColor: AppColor.input,
        border: const OutlineInputBorder(),
        hintText: hint,
        hintStyle: const TextStyle(
          color: AppColor.secondaryText
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: AppColor.input
            ),
            borderRadius: BorderRadius.circular(10)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: AppColor.input
            ),
            borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }
}