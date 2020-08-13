import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:the_hero_brain/models/questionBrain.dart';
import 'package:the_hero_brain/widgets/constants.dart';
import 'package:the_hero_brain/screens/splashScreen.dart';
import 'package:the_hero_brain/utilities/widgets.dart';

enum TtsState { playing, stopped, paused, continued }

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // tr-TR
  // en-US

  QuestionBrain _questionBrain = QuestionBrain();
  List<Icon> scoreKeeper = [];
  bool status;
  FlutterTts tts;
  dynamic languages;
  String language = "tr-TR";
  double volume = 0.7;
  double pitch = 0.9;
  double rate = 0.8;

  TtsState ttsState = TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
    _speakRun(_questionBrain.text);
  }

  initTts() {
    tts = FlutterTts();
    tts.setStartHandler(() => setState(() => ttsState = TtsState.playing));
    tts.setCompletionHandler(() => setState(() => ttsState = TtsState.stopped));
    tts.setCancelHandler(() => setState(() => ttsState = TtsState.stopped));
    if (kIsWeb || Platform.isIOS) {
      tts.setPauseHandler(() => setState(() => ttsState = TtsState.paused));
      tts.setContinueHandler(
          () => setState(() => ttsState = TtsState.continued));
    }
    tts.setErrorHandler((msg) => setState(() {
          print("error: $msg");
          ttsState = TtsState.stopped;
        }));
  }

  Future _speak(String newVoiceText) async {
    await tts.setVolume(volume);
    await tts.setSpeechRate(rate);
    await tts.setPitch(pitch);

    if (newVoiceText != null) {
      if (newVoiceText.isNotEmpty) {
        var result = await tts.speak(newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  void _changeLanguage(String language) {
    setState(() {
      tts.setLanguage(language);
    });
  }

  void _speakRun(String newVoiceText) {
    if (!kIsWeb && Platform.isAndroid) {
      _speak(newVoiceText);
    } else {
      _speak(newVoiceText);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () => onWillPop(context),
        child: Scaffold(
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
                  Text(
                    _questionBrain.text,
                    textScaleFactor: 1.0, // disables accessibility
                    style: TextStyle(fontSize: 40.0),
                  ),
                  SizedBox(
                    height: 50,
                  ),
//                  Row(
//                    children: scoreKeeper,
//                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkAnswer(String answer) {
    String correctAnswer = _questionBrain.answer;

    setState(() {
      if (_questionBrain.isFinished() == true) {
        _questionBrain.reset();
        scoreKeeper = [];
        print("Finished");
        _speakRun(_questionBrain.text);
        //status = "finished";
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
        _speakRun("${status ? "Doğru" : "Yanlış"} bildin");

        Timer(
          Duration(seconds: 3),
          () {
            _questionBrain.nextQuestion();
            _speakRun(_questionBrain.text);
          },
        );
      }
    });
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

  @override
  void dispose() {
    super.dispose();
    tts.stop();
  }
}
