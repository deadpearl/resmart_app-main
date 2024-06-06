import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resmart/app/presentation/ui/home/home_page.dart';
import 'package:resmart/app/presentation/ui/splash/splash_page.dart';

void main() {
  //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(
      MaterialApp(
      // home: SplashPage(),
      home: HomePage(),
    )
  );
}
