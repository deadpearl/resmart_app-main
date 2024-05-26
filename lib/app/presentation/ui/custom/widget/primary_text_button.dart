import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';

class PrimaryTextButton extends StatelessWidget {

  final String name;
  final Function? onClick;

  const PrimaryTextButton({super.key, required this.name, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick?.call();
      },
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        child: Text(
          name,
          style: const TextStyle(
              color: AppColor.primary,
              fontFamily: 'Inter',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: AppColor.primary
          ),
        ),
      ),
    );
  }



}