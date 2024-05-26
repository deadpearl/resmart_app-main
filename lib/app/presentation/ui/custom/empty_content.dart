import 'package:flutter/material.dart';

class EmptyContentWidget extends StatelessWidget {

  const EmptyContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: 400,
      alignment: Alignment.center,
      width: double.infinity,
      child: Text(
        "Пустой контент",
        style: TextStyle(
          color: Colors.black.withOpacity(0.7),
          fontSize: 13,
          fontFamily: 'Rubik'
        ),
      ),
    );
  }
}