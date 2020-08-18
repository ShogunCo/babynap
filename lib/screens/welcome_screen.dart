import "package:flutter/material.dart";
import 'package:the_hero_brain/screens/question_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final tapStrTr = "Ekrana Tıkla ve Başla!";
  final tapStrEn = "Tap To Start!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => QuestionScreen()),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/babynap_bg.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image.network('https://i.gifer.com/YTup.gif'),
                  ),
                  SizedBox(
                    height: 240,
                  ),
                  Text(
                    "$tapStrTr",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
