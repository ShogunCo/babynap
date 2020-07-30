import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:the_hero_brain/models/questionBrain.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

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

  FlutterTts flutterTts;
  dynamic languages;
  String language = "tr-TR";
  double volume = 0.5;
  double pitch = 1.5;
  double rate = 0.7;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  get isPaused => ttsState == TtsState.paused;

  get isContinued => ttsState == TtsState.continued;

  @override
  initState() {
    super.initState();
    initTts();
    _speakRun(_questionBrain.text);
  }

  initTts() {
    flutterTts = FlutterTts();

    _getLanguages();

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        _getEngines();
      }
    }

    flutterTts.setStartHandler(() {
      setState(() {
        print("Playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setCancelHandler(() {
      setState(() {
        print("Cancel");
        ttsState = TtsState.stopped;
      });
    });

    if (kIsWeb || Platform.isIOS) {
      flutterTts.setPauseHandler(() {
        setState(() {
          print("Paused");
          ttsState = TtsState.paused;
        });
      });

      flutterTts.setContinueHandler(() {
        setState(() {
          print("Continued");
          ttsState = TtsState.continued;
        });
      });
    }

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _getEngines() async {
    var engines = await flutterTts.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }

  Future _speak(String newVoiceText) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (newVoiceText != null) {
      if (newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(newVoiceText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  void _changeLanguage(String language) {
    setState(() {
      flutterTts.setLanguage(language);
    });
  }

  Widget _speakRun(String newVoiceText) {
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
      home: Scaffold(
        // Outer white container with padding
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            color: Colors.cyan,
            child: generateImageWidget(
                _questionBrain.listImage, _questionBrain.text),
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
      }

      else {

        if (answer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }

        _questionBrain.nextQuestion();
        _speakRun(_questionBrain.text);
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

  Widget generateImageWidget(List<String> strings, String text) {

    List<Widget> list = List<Widget>();
    for (var i = 0; i < strings.length; i += 2) {
      list.add(screenRow(strings[i], strings[i + 1]));
    }

    list.add(Text(text,
      textScaleFactor: 1.0, // disables accessibility
      style: TextStyle(
          fontSize: 35.0,
      ),));

    list.add(Row(
      children: scoreKeeper,
    ));

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: list,
    );
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }
}
