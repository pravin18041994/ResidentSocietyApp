import 'package:flutter/material.dart';
import 'package:societyappresidents/ui/SplashScreen.dart';
import './ui/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Society App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Raleway',
          appBarTheme:
          AppBarTheme(iconTheme: IconThemeData(color: Colors.black))),
      home: SplashScreen(),
    );
  }
}
