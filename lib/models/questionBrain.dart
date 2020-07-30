import 'package:flutter/cupertino.dart';
import 'question.dart';

class QuestionBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(
      ["square.png",
      "star.png"],
      "Which one star",
      1,
    ),
    Question(
      ["star.png",
      "square.png",
      "star.png",
      "triangle.png"],
      "Which one square",
      2,
    ),
    Question(
      ["star.png",
        "square.png"],
      "Which one star",
      1,
    ),
    Question(
      ["star.png",
        "square.png",
        "star.png",
        "triangle.png"],
      "Which one square",
      2,
    ),
    Question(
      ["square.png",
        "star.png"],
      "Which one star",
      1,
    ),
    Question(
      ["star.png",
        "triangle.png",
        "star.png",
        "triangle.png"],
      "Which one square",
      2,
    ),
  ];

  List get listImage => _questionBank[_questionNumber].listImage;
  String get text => _questionBank[_questionNumber].text;
  int get answer => _questionBank[_questionNumber].answer;

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
