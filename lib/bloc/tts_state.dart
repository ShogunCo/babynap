import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class TtsState {
  dynamic languages;
  String language = "tr-TR";
  double volume = 0.7;
  double pitch = 0.9;
  double rate = 0.8;

  TtsState({this.languages, this.language, this.volume, this.pitch, this.rate});

}

class PlayingState extends TtsState {

}

class StoppedState extends TtsState {

}

class PausedState extends TtsState {

}

class ContinuedState extends TtsState {

}

