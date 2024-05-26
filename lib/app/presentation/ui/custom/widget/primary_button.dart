import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';

class PrimaryButton extends StatelessWidget {

  final String text;
  final Function onPressed;

  const PrimaryButton(
    this.text,
    this.onPressed, {
      super.key,
    }
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          onPressed.call();
        },
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColor.primary,
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: Container(
            width: double.infinity,
            height: 48,
            alignment: Alignment.center,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500
              ),
            ),
          ),
        )
    );
  }
}