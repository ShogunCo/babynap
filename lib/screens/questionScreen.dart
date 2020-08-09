import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:the_hero_brain/models/questionBrain.dart';
import 'package:the_hero_brain/widgets/constants.dart';
import 'package:the_hero_brain/components/splashScreen.dart';
import 'package:the_hero_brain/components/textToSpeech.dart';
import 'package:the_hero_brain/models/widgets.dart';

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

  FlutterTts flutterTts;
  dynamic languages;
  String language = "tr-TR";
  double volume = 0.7;
  double pitch = 0.9;
  double rate = 0.8;

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
    //TextToSpeech(_questionBrain.text);
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

  void _speakRun(String newVoiceText) {
    if (!kIsWeb && Platform.isAndroid) {
      _speak(newVoiceText);
    } else {
      _speak(newVoiceText);
    }
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Eminmisiniz?'),
            content: Text('Testden çıkmak istiyor musunuz?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Hayır'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Evet'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          // Outer white container with padding
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
    flutterTts.stop();
  }
}
