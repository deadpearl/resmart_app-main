import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';

const double ICON_OFF = -3;
const double ICON_ON = 0;
const double TEXT_OFF = 3;
const double TEXT_ON = 1;
const double ALPHA_OFF = 0;
const double ALPHA_ON = 1;
const int ANIM_DURATION = 300;

class MotionTabItem extends StatefulWidget {
  final String title;
  final bool selected;
  final String iconData;
  final Function callbackFunction;

  const MotionTabItem({
    super.key,
    required this.title,
    required this.selected,
    required this.iconData,
    required this.callbackFunction,
  });

  @override
  State<MotionTabItem> createState() => _MotionTabItem();
}

class _MotionTabItem extends State<MotionTabItem> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          widget.callbackFunction();
        },
        child: Container(
          padding: const EdgeInsets.only(bottom: 5, top: 5),
          child: Column(
            children: [
              Image.asset(
                widget.iconData,
                width: 30,
                height: 30,
                color: widget.selected ? AppColor.primary : AppColor.inactive,
              ),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.normal,
                  color: widget.selected ? AppColor.primary : AppColor.inactive,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
