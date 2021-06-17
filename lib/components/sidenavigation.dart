import 'package:flutter/material.dart';
import 'package:idea_tracker/utilities/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:idea_tracker/screens/welcomescreen.dart';
class SideNavigation extends StatelessWidget {
  final String phonenumber;
  SideNavigation(this.phonenumber);
  @override
  Widget build(BuildContext context) {
   final width=MediaQuery.of(context).size.width;
    return Container(
      width: width/2,
      child: Drawer(
        child: Container(
          color: kthemecolour,
          //width: 40,
          padding: EdgeInsets.fromLTRB(10, 60, 10, 20),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(Icons.person,
                size: 40,
                color: kthemecolour,),
              ),
              SizedBox(height: 10,),
              Text(
                phonenumber,
                style: ksidetextstyle,
              ),
              SizedBox(height: 10,),
              GestureDetector(
                child: Text(
                  'Logout',
                style: ksidetextstyle,
                ),
                onTap: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(context, new MaterialPageRoute(builder:  (BuildContext context) => WelcomeScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
