import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dashboard.dart';
import 'welcomescreen.dart';
class ChooseLogin extends StatelessWidget {
  static const String id='chooselogin';
  final FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    if(_auth.currentUser != null){
      return DashBoard(_auth.currentUser);
    }
    else{
      return WelcomeScreen();
    }
  }
}
