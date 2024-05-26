import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';

class HeaderText extends StatelessWidget {

  final String text;
  final double size;
  final TextAlign textAlign;

  const HeaderText(
    this.text, {
      super.key,
      this.size = 24,
      this.textAlign = TextAlign.start
    }
  );

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: AppColor.text,
          fontFamily: 'Rubik',
          fontWeight: FontWeight.w600,
          fontSize: size
      ),
    );
  }
}