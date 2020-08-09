import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_hero_brain/widgets/constants.dart';
import 'package:the_hero_brain/screens/questionScreen.dart';

class SplashScreen extends StatefulWidget {

  bool status;

  @override
  _SplashScreenState createState() => new _SplashScreenState(status);

  SplashScreen(this.status);
}

class _SplashScreenState extends State<SplashScreen> {

  bool status;

  _SplashScreenState(this.status);

  @override
  void initState (){
    super.initState();

    Timer(
        Duration(seconds: 3),
            () =>
                Navigator.of(context).pop(false));
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home:  Scaffold(
        // Outer white container with padding
        body: SafeArea(
          child: Center(

            child: Text("${status ? "Doğru": "Yanlış"} bildin",
              textScaleFactor: 1.0, // disables accessibility
              style: TextStyle(
                fontSize: 35.0,
              ),),
          ),
        ),
      ),
    );
  }
}