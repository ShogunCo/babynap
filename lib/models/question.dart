import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Question {

  List<String> _listImage;
  String _text;
  int _answer;

  Question(List<String> listImage, String text, int answer) {
    _listImage = listImage;
    _text = text;
    _answer = answer;
  }

  List<String> get listImage => _listImage;
  String get text => _text;
  int get answer => _answer;
}