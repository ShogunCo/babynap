import 'dart:async';
import 'package:flutter/material.dart';
import 'package:the_hero_brain/utilities/tts_util.dart';
import 'package:the_hero_brain/widgets/constants.dart';

class FeedBackScreen extends StatefulWidget {
  final bool status;

  FeedBackScreen(this.status);

  @override
  _FeedBackScreenState createState() => new _FeedBackScreenState();

}

class _FeedBackScreenState extends State<FeedBackScreen> {

  Tts tts = Tts();

  @override
  void initState() {
    super.initState();
    tts.speak("${widget.status ? "Doğru" : "Yanlış"} bildin");
    Timer(Duration(seconds: 3), () => Navigator.of(context).pop(false));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: scaffoldBC),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          // Outer white container with padding
          body: SafeArea(
            child: Center(
              child: Text(
                "${widget.status ? "Doğru" : "Yanlış"} bildin",
                textScaleFactor: 1.0, // disables accessibility
                style: TextStyle(
                  fontSize: 35.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
