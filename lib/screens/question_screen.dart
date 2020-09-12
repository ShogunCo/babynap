import 'package:flutter/material.dart';
import 'dart:async';
import 'package:the_hero_brain/models/question_brain.dart';
import 'package:the_hero_brain/screens/resultScreen.dart';
import 'package:the_hero_brain/widgets/constants.dart';
import 'package:the_hero_brain/screens/feedBack_screen.dart';
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

  //List<bool> scoreKeeper = [];
  int trueAnswer = 0;
  int falseAnswer = 0;
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
            child: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        padding: const EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: generateImageWidget(_questionBrain.listImage),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => tts.speak(_questionBrain.text),
            child: Icon(
              Icons.record_voice_over,
              color: Colors.white,
            ),
            backgroundColor: Colors.green,
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
        MaterialPageRoute(
            builder: (context) => ResultScreen(trueAnswer, falseAnswer)),
      );
    } else {
      if (answer == correctAnswer) {
        status = true;
        //scoreKeeper.add(true);
        trueAnswer++;
      } else {
        status = false;
        //scoreKeeper.add(false);
        falseAnswer++;
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FeedBackScreen(status)),
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

  FlatButton resultButton(String shape) => FlatButton(
        child: Image.asset(
          'assets/images/$shape',
          height: 80,
          width: 80,
        ),
        onPressed: () {
          checkAnswer(shape);
        },
      );

  List<Widget> generateImageWidget(List<String> strings) {
    List<Widget> list = List<Widget>();
    for (int i = 0; i < strings.length; i += 1) {
      list.add(
        Container(
          padding: const EdgeInsets.all(8),
          child: resultButton(strings[i]),
          color: Colors.indigo,
        ),
      );
    }

    return list;
  }
}
