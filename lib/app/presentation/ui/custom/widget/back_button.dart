import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {

  final Function onPressed;
  final EdgeInsets margins;

  const ButtonBack(this.onPressed, {super.key, this.margins = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margins,
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12)
      ),
      child: InkWell(
        onTap: () {
          onPressed.call();
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
    );
  }

}