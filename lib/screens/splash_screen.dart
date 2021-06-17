import 'package:flutter/material.dart';
import 'dart:async';
import 'chooselogin.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
    //  Navigator.of(context).pushReplacement(
      //    new MaterialPageRoute(builder: (context) => WelcomeScreen()));
      Navigator.pushNamed(context, ChooseLogin.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0XFFFDC57E),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: 300,
                height: 300,
                child: Image(image: AssetImage('assets/images/IdeaLogo1.png'))),
            Padding(
                padding: EdgeInsets.only(top: 100),
                child: Container(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(
                     //   strokeWidth: 80,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
