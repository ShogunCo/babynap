import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_hero_brain/utilities/widgets.dart';
import 'package:the_hero_brain/widgets/constants.dart';

class ResultScreen extends StatefulWidget {
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:  () => Future.value(false),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.cyan,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Text("Sonuç"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
