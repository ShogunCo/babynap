import 'package:flutter_tts/flutter_tts.dart';

class Tts {
  FlutterTts tts = FlutterTts();
  String language = "tr-TR";

  Tts() {
    tts.setLanguage(language);
  }

  Future setLanguage(String language) async => await tts.setLanguage(language);

  Future speak(String newVoiceText) async {
    await tts.speak(newVoiceText);
  }

  void dispose() {
    tts.stop();
  }
}
