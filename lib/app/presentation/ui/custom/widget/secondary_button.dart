import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';

class SecondaryButton extends StatelessWidget {

  final String text;
  final Color? buttonBackground;
  final Function? onPressed;

  const SecondaryButton({super.key, required this.text, this.onPressed, this.buttonBackground});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onPressed?.call(),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
          ),
          child: Container(
            width: double.infinity,
            height: 48,
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                  color: AppColor.primary,
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
        )
    );
  }
}