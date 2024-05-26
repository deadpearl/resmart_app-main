import 'package:flutter/material.dart';

class AppOutlinedButton extends StatelessWidget {

  final String text;
  final Color? buttonBackground;
  final Function? onPressed;

  const AppOutlinedButton({super.key, required this.text, this.onPressed, this.buttonBackground});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onPressed?.call(),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.white)
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
                  fontWeight: FontWeight.w600
              ),
            ),
          ),
        )
    );
  }
}