import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_hero_brain/screens/welcome_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:the_hero_brain/utilities/widgets.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      pushPage(context, WelcomeScreen());
    } else {
      await prefs.setBool('seen', true);

      pushPage(context, OnboardingScreen());
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Center(
          child: Text("Yükleniyor..."),
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => WelcomeScreen()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/gifs/$assetName', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: IntroductionScreen(
            key: introKey,
            pages: [
              PageViewModel(
                title: "Çocuk ve Aile",
                body: "Çocuklarınızı 7/24 takip edin. "
                    "Desteğe ihtiyaç duyan bir çocuğa yardım etmek için daima hazır olun. Ve ihtiyaç duyduğu her şeyi bulduğunda, yanında durun.",
                image: _buildImage('family1.jpg'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Şefkat Eğitimin Bir Parçasıdır",
                body: "Çocuğunuza hata yaptığında dahi saygı duyun. Böylelikle hatalarını çabucak düzeltebilir.",
                image: _buildImage('family2.jpg'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "İlgi Destektir",
                body: "Bir çocuk destek gördüğünde, kendine güveni artar.",
                image: _buildImage('family3.jpg'),
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
            showSkipButton: true,
            skipFlex: 0,
            nextFlex: 0,
            skip: const Text('Geç'),
            next: const Icon(Icons.arrow_forward),
            done: const Text('Bitti',
                style: TextStyle(fontWeight: FontWeight.w600)),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
