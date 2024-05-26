import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/motion_tab_controller.dart';
import 'package:resmart/app/presentation/ui/custom/navigation/motion_tab_item.dart';

typedef MotionTabBuilder = Widget Function();

class MotionTabBar extends StatefulWidget {
  final Function? onTabItemSelected;
  final String initialSelectedTab;

  final List<String?> labels;
  final List<String>? iconPath;
  final bool useSafeArea;
  final MotionTabBarController? controller;

  MotionTabBar({
    super.key,
    this.onTabItemSelected,
    required this.initialSelectedTab,
    required this.labels,
    this.iconPath,
    this.useSafeArea = true,
    this.controller,
  })  : assert(labels.contains(initialSelectedTab)),
        assert(iconPath != null && iconPath.length == labels.length);

  @override
  State<MotionTabBar> createState() => _MotionTabBar();
}

class _MotionTabBar extends State<MotionTabBar> with TickerProviderStateMixin {

  late AnimationController _animationController;
  late Tween<double> _positionTween;
  late Animation<double> _positionAnimation;


  late List<String?> labels;
  late Map<String?, String> icons;

  get tabAmount => icons.keys.length;
  get index => labels.indexOf(selectedTab);
  get position {
    double pace = 2 / (labels.length - 1);
    return (pace * index) - 1;
  }

  double fabIconAlpha = 1;
  String? activeIcon;
  String? selectedTab;

  List<Widget>? badges;
  Widget? activeBadge;

  @override
  void initState() {
    super.initState();

    if(widget.controller != null) {
      widget.controller!.onTabChange= (index) {
        setState(() {
          activeIcon = widget.iconPath![index];
          selectedTab = widget.labels[index];
        });
        _initAnimationAndStart(_positionAnimation.value, position);
      };
    }

    labels = widget.labels;
    icons = { for (var label in labels) label : widget.iconPath![labels.indexOf(label)] };

    selectedTab = widget.initialSelectedTab;
    activeIcon = icons[selectedTab];

    _animationController = AnimationController(
      duration: const Duration(milliseconds: ANIM_DURATION),
      vsync: this,
    );

    _positionTween = Tween<double>(begin: position, end: 1);

    _positionAnimation = _positionTween.animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, -1),
            blurRadius: 5,
          ),
        ],
      ),
      child: SafeArea(
        bottom: widget.useSafeArea,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: generateTabItems(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> generateTabItems() {
    return labels.map((tabLabel) {
      String icon = icons[tabLabel]!;
      return MotionTabItem(
        selected: selectedTab == tabLabel,
        iconData: icon,
        title: tabLabel!,
        callbackFunction: () {
          setState(() {
            activeIcon = icon;
            selectedTab = tabLabel;
            widget.onTabItemSelected!(index);
          });
          _initAnimationAndStart(_positionAnimation.value, position);
        },
      );
    }).toList();
  }

  _initAnimationAndStart(double from, double to) {
    _positionTween.begin = from;
    _positionTween.end = to;

    _animationController.reset();
    _animationController.forward();
  }
}

