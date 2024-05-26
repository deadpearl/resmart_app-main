import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {

  final IconData icon;
  final Function? onClick;

  const ButtonIcon({super.key, required this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick?.call();
      },
      borderRadius: BorderRadius.circular(100),
      child: Container(
        alignment: Alignment.centerLeft,
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        child: Icon(
          icon,
          size: 24,
          color: Colors.black,
        ),
      ),
    );
  }



}