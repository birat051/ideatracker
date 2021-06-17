import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/welcomescreen.dart';
import 'screens/chooselogin.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
/*  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
  ); */
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
 //         backgroundColor: Color(0XFFF9F6E9),
 //         hintColor: Colors.yellowAccent,
          fontFamily: 'Raleway',
 //       primaryColor: Color(0XFFFDC57E)
      ),
      initialRoute: SplashScreen.id,
    routes: {
    SplashScreen.id: (context) => SplashScreen(),
    WelcomeScreen.id: (context) => WelcomeScreen(),
      ChooseLogin.id: (context)=> ChooseLogin()
  }
  );
  }
}




