import 'package:flutter/material.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_color.dart';
import 'package:resmart/app/presentation/ui/custom/constant/app_size.dart';
import 'package:resmart/app/presentation/ui/custom/empty_content.dart';
import 'package:resmart/app/presentation/ui/custom/widget/back_button.dart';
import 'package:resmart/app/presentation/ui/custom/widget/header_text.dart';

class FeedBackPage extends StatefulWidget {

  const FeedBackPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FeedBackPage();
  }
}

class _FeedBackPage extends State<FeedBackPage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: AppSize.topMargin),
                  height: 40,
                  child: Stack(
                    children: [
                      const Center(
                        child: HeaderText("Мои отзывы"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16, right: AppSize.horizontal),
                        child: ButtonBack(() {
                          Navigator.of(context).pop();
                        }),
                      ),
                    ],
                  ),
                ),
                const EmptyContentWidget()
              ],
            )
        ),
      ),
    );
  }
}