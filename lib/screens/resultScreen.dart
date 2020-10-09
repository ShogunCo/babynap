import 'dart:math';

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
  Random rnd = Random();

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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(rnd.nextInt(3) == 0
                      ? "assets/gifs/flowers.gif"
                      : rnd.nextInt(3) == 1
                      ? "assets/gifs/greenStar.gif"
                      : "assets/gifs/firework.gif"),
                  fit: BoxFit.cover,
                ),
              ),
              padding: EdgeInsets.all(40),
              //color: Colors.cyan,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),

                    Expanded(
                      child: Center(
                        child: Container(
                          color: Colors.redAccent.withOpacity(0.6),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Sonuç",
                                  style: TextStyle(

                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                  "Doğru : ${widget._trueAnswer}",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  )),

                              Text(
                                  "Yanlış : ${widget._falseAnswer}",
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 100,
                    ),
                    Expanded(
                        child: Image.asset(rnd.nextInt(3) == 0
                            ? "assets/gifs/dogs.gif"
                            : rnd.nextInt(3) == 1
                                ? "assets/gifs/girl.gif"
                                : "assets/gifs/boy.gif")),
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
