import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resmart/app/presentation/ui/splash/splash_page.dart';

void main() {
  //SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(
    const MaterialApp(
      home: SplashPage(),
    )
  );
}
