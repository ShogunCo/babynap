import 'dart:convert';
import 'question.dart';
import 'dart:math';
import 'package:the_hero_brain/models/content.dart';

class QuestionBrain {
  static int _questionNumber = 0;
  List<Question> _questionBank = [];
  final Map<String, dynamic> _nature = json.decode(natureJson);
  final Map<String, dynamic> _plant = json.decode(plantJson);
  final Map<String, dynamic> _animal = json.decode(animalJson);
  final Map<String, dynamic> _thing = json.decode(thingJson);
  final Map<String, dynamic> _qText = json.decode(receivedTextJson);
  List<String> _newImg = new List<String>();
  List<String> _newTr = new List<String>();
  String _img;
  String _tr;


  QuestionBrain() {
    _prepareQuestions();
  }

  void _generateRandomImage() {

    Random random = new Random();

    final int randCate = random.nextInt(4);
    switch (randCate) {
      case 0:
        final int randObj = random.nextInt(_nature.length);

        final int randPart = random.nextInt(_nature[randObj.toString()]["n"]);
        String en = _nature[randObj.toString()]["en"];
        _tr = _nature[randObj.toString()]["tr"];
        _img = "nature/" + en + "/" + en + "_" + randPart.toString();
        break;
      case 1:
        final int randObj = random.nextInt(_plant.length);

        final int randPart = random.nextInt(_plant[randObj.toString()]["n"]);
        String en = _plant[randObj.toString()]["en"];
        _tr = _plant[randObj.toString()]["tr"];
        _img = "plant/" + en + "/" + en + "_" + randPart.toString();
        break;
      case 2:
        final int randObj = random.nextInt(_animal.length);

        final int randPart = random.nextInt(_animal[randObj.toString()]["n"]);
        String en = _animal[randObj.toString()]["en"];
        _tr = _animal[randObj.toString()]["tr"];
        _img = "animal/" + en + "/" + en + "_" + randPart.toString();
        break;
      case 3:
        final int randObj = random.nextInt(_thing.length);

        final int randPart = random.nextInt(_thing[randObj.toString()]["n"]);
        String en = _thing[randObj.toString()]["en"];
        _tr = _thing[randObj.toString()]["tr"];
        _img = "thing/" + en + "/" + en + "_" + randPart.toString();
        break;
    }
  }

  void _generateRandomImageList(int size) {
    _newImg.clear();
    _newTr.clear();
    while(_newTr.length < size) {
      _generateRandomImage();
      if (!_newTr.contains(_tr)) {
        _newImg.add(_img);
        _newTr.add(_tr);
      }
    }
  }

  void _prepareQuestions() {

    var rndTextList = new List<int>.generate(_qText.length, (int index) => index)
      ..shuffle();



    int j = 0;
    for (int i = 0; i < 2; i++, j++) {
      _generateRandomImageList(2);
      _questionBank.add(
        Question(
          [
            _newImg[0],
            _newImg[1],
          ]..shuffle(),
          _qText["item" + rndTextList[j % _qText.length].toString()]["text1"] +
              _newTr[0] +
              _qText["item" + rndTextList[j % _qText.length].toString()]["text2"],
          _newImg[0],
        ),
      );
    }


    for (int i = 0; i < 2; i++, j++) {
      _generateRandomImageList(4);
      _questionBank.add(
        Question(
          [
            _newImg[0],
            _newImg[1],
            _newImg[2],
            _newImg[3],
          ]..shuffle(),
          _qText["item" + rndTextList[j % _qText.length].toString()]["text1"] +
              _newTr[0] +
              _qText["item" + rndTextList[j % _qText.length].toString()]["text2"],
          _newImg[0],
        ),
      );
    }


    for (int i = 0; i < 2; i++, j++) {
      _generateRandomImageList(6);
      _questionBank.add(
        Question(
          [
            _newImg[0],
            _newImg[1],
            _newImg[2],
            _newImg[3],
            _newImg[4],
            _newImg[5],
          ]..shuffle(),
          _qText["item" + rndTextList[j % _qText.length].toString()]["text1"] +
              _newTr[0] +
              _qText["item" + rndTextList[j % _qText.length].toString()]["text2"],
          _newImg[0],
        ),
      );
    }
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
