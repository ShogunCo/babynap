import 'package:flutter/material.dart';
import 'dart:async';
import 'package:the_hero_brain/models/question_brain.dart';
import 'package:the_hero_brain/screens/resultScreen.dart';
import 'package:the_hero_brain/widgets/constants.dart';
import 'package:the_hero_brain/screens/splash_screen.dart';
import 'package:the_hero_brain/utilities/widgets.dart';
import 'package:the_hero_brain/utilities/tts_util.dart';

enum TtsState { playing, stopped, paused, continued }

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // tr-TR
  // en-US

  QuestionBrain _questionBrain = QuestionBrain();
  Tts tts = Tts();
  List<Icon> scoreKeeper = [];
  bool status;

  @override
  initState() {
    super.initState();
    // initTts();
    tts.speak(_questionBrain.text);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => questionOnWillPop(context),
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: generateImageWidget(_questionBrain.listImage),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            height: 90.0,
            width: double.infinity,
            color: Colors.white,
            child: Center(
              child: Text(
                _questionBrain.text,
                style: TextStyle(
                  color: Color(0xFF5B16D0),
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkAnswer(String answer) {
    String correctAnswer = _questionBrain.answer;

    if (_questionBrain.isFinished() == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ResultScreen()),
      );
    } else {
      if (answer == correctAnswer) {
        status = true;
        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        status = false;
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen(status)),
      );
      //pushPage(context, SplashScreen(status));

      Timer(
        Duration(seconds: 3),
        () {
          setState(() {
            _questionBrain.nextQuestion();
            tts.speak(_questionBrain.text);
          });
        },
      );
    }
  }

  Row screenRow(String image1, String image2) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          resultButton(image1),
          resultButton(image2),
        ],
      );

  Expanded resultButton(String shape) => Expanded(
        child: FlatButton(
          child: Image.asset(
            'assets/images/$shape',
            height: 80,
            width: 80,
          ),
          onPressed: () {
            checkAnswer(shape);
          },
        ),
      );

  List<Widget> generateImageWidget(List<String> strings) {
    List<Widget> list = List<Widget>();

    for (var i = 0; i < strings.length; i += 2) {
      list.add(screenRow(strings[i], strings[i + 1]));
    }
    return list;
  }
}
