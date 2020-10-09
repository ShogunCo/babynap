import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_hero_brain/screens/question_screen.dart';
import 'package:the_hero_brain/utilities/widgets.dart';
import 'package:the_hero_brain/widgets/constants.dart';

class PreparationScreen extends StatefulWidget {
  @override
  _PreparationScreenState createState() => _PreparationScreenState();
}

class _PreparationScreenState extends State<PreparationScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => questionOnWillPop(context),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: scaffoldBC),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: SafeArea(
            child: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GridView.count(
                        shrinkWrap: true,
                        primary: false,
                        padding: EdgeInsets.all(20),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        children: [
                          level("5 soru", 5),
                          level("10 soru", 10),
                          level("20 soru", 20),
                          level("25 soru", 25),
                          level("35 soru", 35),
                          level("40 soru", 40),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget level(String text, int command) => FlatButton(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Card(
              shadowColor: Colors.blueAccent,
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Container(
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                             Image.asset("assets/gifs/star.gif"),
                            ],
                          ))),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        //mainAxisSize: MainAxisSize.min,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Icon(Icons.question_answer,
                              size: 60.0, color: Colors.blue),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            text,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => QuestionScreen(command)),
        ),
      );
}
