import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';

class DescriptionText extends StatelessWidget {

  final String text;
  final TextAlign textAlign;

  static TextStyle style = const TextStyle(
    color: AppColor.secondaryText,
    fontFamily: 'Rubik',
    fontSize: 16
  );

  const DescriptionText(
    this.text, {
      super.key,
      this.textAlign = TextAlign.start
    }
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: style,
    );
  }
}