import 'question.dart';

class QuestionBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(
      [
        "square.png",
        "star.png",
      ],
      "Hangisi Yıldız",
      "star.png",
    ),
    Question(
      [
        "square.png",
        "triangle.png",
      ],
      "Hangisi Kare",
      "square.png",
    ),
    Question(
      [
        "cross.png",
        "moon.png",
        "letter.png",
        "sun.png",
      ],
      "Hangisi Güneş",
      "sun.png",
    ),
    Question(
      [
        "star.png",
        "box.png",
        "heart.png",
        "triangle.png",
      ],
      "Hangisi Kalp",
      "heart.png",
    ),
    Question(
      [
        "heart.png",
        "letter.png",
        "star.png",
        "cloud.png",
        "square.png",
        "box.png",
      ],
      "Hangisi Bulut",
      "cloud.png",
    ),
    Question(
      [
        "arrow.png",
        "box.png",
        "clock.png",
        "child.png",
        "letter.png",
        "sun.png",
      ],
      "Hangisi Kutu",
      "box.png",
    ),
  ];

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
