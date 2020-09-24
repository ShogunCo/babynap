import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:the_hero_brain/screens/welcome_screen.dart';
import 'package:the_hero_brain/widgets/constants.dart';

class ResultScreen extends StatefulWidget {
  final int _trueAnswer;
  final int _falseAnswer;

  ResultScreen(this._trueAnswer, this._falseAnswer);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: scaffoldBC),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.all(40),
              color: Colors.cyan,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Text("Sonuç",
                        style: TextStyle(
                          color: Color(0xFF5B16D0),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                        "Doğru / Yanlış : ${widget._trueAnswer} / ${widget._falseAnswer}",
                        style: TextStyle(
                          color: Color(0xFF5B16D0),
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: FlatButton(
            color: Colors.redAccent,
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WelcomeScreen(),
              ),
            ),
            child: Container(
              height: 100,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("TEKRAR OYNA",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}