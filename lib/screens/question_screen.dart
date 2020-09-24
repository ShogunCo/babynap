import 'package:flutter/material.dart';
import 'dart:async';
import 'package:the_hero_brain/models/question_brain.dart';
import 'package:the_hero_brain/screens/resultScreen.dart';
import 'package:the_hero_brain/widgets/constants.dart';
import 'package:the_hero_brain/utilities/widgets.dart';
import 'package:the_hero_brain/utilities/tts_util.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // tr-TR
  // en-US

  QuestionBrain _questionBrain = QuestionBrain();
  Tts tts = Tts();
  int trueAnswer = 0;
  int falseAnswer = 0;
  bool status;

  @override
  initState() {
    super.initState();
    _questionBrain.reset(); // add later
    tts.speak(_questionBrain.text);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => questionOnWillPop(context),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: scaffoldBC),
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
                        //padding: EdgeInsets.all(20),
                        //crossAxisSpacing: 10,
                        //mainAxisSpacing: 10,
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

    if (answer == correctAnswer) {
      status = true;
      trueAnswer++;
    } else {
      status = false;
      falseAnswer++;
    }

    showDialog(
      barrierDismissible: false,
      //barrierColor: Colors.brown,
      context: context,
      builder: (context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop(true);
        });

        tts.speak("${status ? "Doğru" : "Yanlış"} bildin");

        return AlertDialog(
          title: Text("${status ? "Harika" : "Olamaz"}"),
          content: Text(
            "${status ? "Doğru" : "Yanlış"} bildin",
            textScaleFactor: 1.0, // disables accessibility
            style: TextStyle(
              fontSize: 35.0,
            ),
          ),
        );
      },
    );

    if (_questionBrain.isFinished() == false) {
      Timer(Duration(seconds: 3), () => tts.speak(_questionBrain.text));

      setState(() {
        _questionBrain.nextQuestion();
      });
    } else {
      Timer(
          Duration(seconds: 3, milliseconds: 100),
          () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ResultScreen(trueAnswer, falseAnswer)),
              ));
    }
  }

  FlatButton resultButton(String shape) => FlatButton(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Image.asset(
            'assets/images/$shape.jpg',
            //height: 100,
            //width: 100,
          ),
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
          //padding: const EdgeInsets.all(0),
          child: resultButton(strings[i]),
          //color: Colors.indigo,
        ),
      );
    }
    return list;
  }
}
