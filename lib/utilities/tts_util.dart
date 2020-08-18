import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

enum TtsState { playing, stopped, paused, continued }

class TtsUtil extends StatefulWidget {
  dynamic languages;
  String language = "tr-TR";
  double volume = 0.7;
  double pitch = 0.9;
  double rate = 0.8;
  TtsState ttsState = TtsState.stopped;

  TtsUtil(
      {Key key,
      this.languages,
      this.language,
      this.volume,
      this.pitch,
      this.rate,
      this.ttsState})
      : super(key: key);

  @override
  _TtsUtilState createState() => _TtsUtilState(
      language: language,
      languages: languages,
      volume: volume,
      pitch: pitch,
      rate: rate,
      ttsState: ttsState);
}

class _TtsUtilState extends State<TtsUtil> {
  FlutterTts tts;
  dynamic languages;
  String language;
  double volume;
  double pitch;
  double rate;
  TtsState ttsState;

  _TtsUtilState(
      {Key key,
      this.languages,
      this.language,
      this.volume,
      this.pitch,
      this.rate,
      this.ttsState});

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

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
