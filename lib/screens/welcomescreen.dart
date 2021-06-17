import 'dashboard.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:idea_tracker/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:loading_overlay/loading_overlay.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  FirebaseAuth _auth;
  TextEditingController _codeController;
  String phonenumber;
  bool _saving=false;
  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _saving=false;
    controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = ColorTween(begin: Color(0XFFFDC57E), end: Colors.white70)
        .animate(controller);
    controller.forward();
    _codeController = TextEditingController();
    controller.addListener(() {
      setState(() {});
    });
  }
  void singIn(FirebaseAuth auth,AuthCredential credential) async
  {

    UserCredential result =
        await auth.signInWithCredential(credential);
    User user = result.user;
    if(user!=null){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DashBoard(
                user,
              )));
    } else {
      setState(() {
        _saving=false;
      });
      print("Error");
    }
  }
  Future<void> loginUser(String phone, BuildContext context) async {
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();
          UserCredential result = await _auth.signInWithCredential(credential);
          User user = result.user;
          if (user != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DashBoard(
                          user,
                        )));
          } else {
            print("Unable to auto login using OTP");
          }
        },
        timeout: Duration(seconds: 60),
        verificationFailed: (FirebaseAuthException exception) {
          print('Unable to validate OTP');
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Builder(
                  builder: (context) =>  AlertDialog(
                    title: Text("Enter OTP sent to $phonenumber"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextField(
                          controller: _codeController,
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Color(0XFFFDC57E),
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30)),
                          child: Text("Confirm"),
                          onPressed: (){
                            FocusScope.of(context).unfocus();
                            final code = _codeController.text.trim();
                            print('OTP Code entered is $code');
                            AuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: code);
                            setState(() {
                              _saving=true;
                            });
                            singIn(_auth, credential);
                            Navigator.of(context).pop();
                          })
                    ],
                  ),
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Builder(
        builder: (context)=> LoadingOverlay(
          isLoading: _saving,
      child: Container(
               color: animation.value,
               width: double.infinity,
               height: double.infinity,
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.stretch,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                         child: Image.asset(
                             'assets/images/IdeaSignInLogo.png'),
                         height: 60,
                       ),
                       SizedBox(
                         width: 20,
                       ),
                       AnimatedTextKit(
                         repeatForever: true,
                         animatedTexts: [
                           TypewriterAnimatedText('IdeaKit',
                               textStyle: TextStyle(
                                   fontSize: 60,
                                   fontFamily: 'Lora',
                                   fontWeight: FontWeight.bold)),
                         ],
                       ),
                     ],
                   ),
                   Padding(
                     padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                     child: TextField(
                       onChanged: (value) {
                         phonenumber = value;
                       },
                       textAlign: TextAlign.center,
                       keyboardType: TextInputType.phone,
                       style: TextStyle(
                           fontSize: 22,
                           fontWeight: FontWeight.w700,
                           fontFamily: 'Lora',
                           color: Colors.white),
                       // style: kSnackTextStyle,
                       decoration: InputDecoration(
                         fillColor: Color(0XFFFDC57E),
                         filled: true,
                         hintText: 'Enter your Phone Number...',
                         hintStyle: TextStyle(
                             fontSize: 22,
                             fontWeight: FontWeight.w700,
                             fontFamily: 'Lora',
                             color: Colors.white),
                         suffixIcon: Icon(
                           Icons.phone,
                           color: Colors.white,
                           size: 30,
                         ),
                         border: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(20.0),
                         ),
                       ),
                     ),
                   ),
                   Padding(
                       padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                       child: RoundedButton(
                         title: 'Login',
                         colour: Color(0XFFFDC57E),
                         onPressed: () {
                           FocusScope.of(context).unfocus();
                         loginUser('+91 $phonenumber', context);
                         },
                       )),
                 ],
               ),
             ),
      ),),
    );
  }
}
