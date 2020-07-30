class Question {

  List<String> _listImage;
  String _text;
  String _answer;

  Question(List<String> listImage, String text, String answer) {
    _listImage = listImage;
    _text = text;
    _answer = answer;
  }

  List<String> get listImage => _listImage;
  String get text => _text;
  String get answer => _answer;
}