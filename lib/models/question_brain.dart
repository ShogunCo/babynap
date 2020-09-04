import 'dart:convert';

import 'question.dart';
import 'dart:math';
import 'package:the_hero_brain/models/content.dart';

class QuestionBrain {
  QuestionBrain() {
    _prepareQuestions();
  }

  static int _questionNumber = 0;
  Random random = new Random();
  List<Question> _questionBank = [];

  void _prepareQuestions() {
    final Map<String, dynamic> img = json.decode(receivedImageJson);
    final Map<String, dynamic> text = json.decode(receivedTextJson);

    int imgLength = img.length;
    int textLength = text.length;

    var rndList = new List<int>.generate(imgLength, (int index) => index)
      ..shuffle();
    var rndTextList = new List<int>.generate(textLength, (int index) => index)
      ..shuffle();

    int j = 0;

    for (int i = 0; i < 2; i++, j++)
      _questionBank.add(
        Question(
          [
            img["item" + rndList[j].toString()]["img"],
            img["item" + rndList[(j + 2) % imgLength].toString()]["img"],
          ]..shuffle(),
          text["item" + rndTextList[j % textLength].toString()]["text1"] +
              img["item" + rndList[j].toString()]["name"] +
              text["item" + rndTextList[j % textLength].toString()]["text2"],
          img["item" + rndList[j].toString()]["img"],
        ),
      );

    for (int i = 0; i < 2; i++, j++)
      _questionBank.add(
        Question(
          [
            img["item" + rndList[j].toString()]["img"],
            img["item" + rndList[(j + 2) % imgLength].toString()]["img"],
            img["item" + rndList[(j + 3) % imgLength].toString()]["img"],
            img["item" + rndList[(j + 4) % imgLength].toString()]["img"],
          ]..shuffle(),
          text["item" + rndTextList[j % textLength].toString()]["text1"] +
              img["item" + rndList[j].toString()]["name"] +
              text["item" + rndTextList[j % textLength].toString()]["text2"],
          img["item" + rndList[j].toString()]["img"],
        ),
      );

    for (int i = 0; i < 2; i++, j++)
      _questionBank.add(
        Question(
          [
            img["item" + rndList[j].toString()]["img"],
            img["item" + rndList[(j + 2) % imgLength].toString()]["img"],
            img["item" + rndList[(j + 3) % imgLength].toString()]["img"],
            img["item" + rndList[(j + 4) % imgLength].toString()]["img"],
            img["item" + rndList[(j + 5) % imgLength].toString()]["img"],
            img["item" + rndList[(j + 6) % imgLength].toString()]["img"],
          ]..shuffle(),
          text["item" + rndTextList[j % textLength].toString()]["text1"] +
              img["item" + rndList[j].toString()]["name"] +
              text["item" + rndTextList[j % textLength].toString()]["text2"],
          img["item" + rndList[j].toString()]["img"],
        ),
      );
  }

  List get listImage => _questionBank[_questionNumber].listImage;

  String get text => _questionBank[_questionNumber].text;

  String get answer => _questionBank[_questionNumber].answer;

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
      print(_questionBank.length);
    }
  }

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
