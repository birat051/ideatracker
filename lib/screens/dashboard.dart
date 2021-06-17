import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:idea_tracker/components/addtask.dart';
import 'package:idea_tracker/components/idealist.dart';
import 'package:idea_tracker/utilities/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:idea_tracker/components/sidenavigation.dart';
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashBoard extends StatefulWidget {
  final User user;
  DashBoard(this.user);
  @override
  _DashBoardState createState() => _DashBoardState();
}
class _DashBoardState extends State<DashBoard> {
  int ideacount;
  var _timer;
  int index=0;
  List<IdeaList> ideas=[];
  FirebaseFirestore _dbobject;
  int determinePriority(String priority){
    switch (priority){
      case 'High':
        return 1;
        break;
      case 'Normal':
        return 2;
        break;
      default:
        return 3;
    }
  }
  void setIdeaCount(){
    setState(() {
      ideacount=ideas.length;
    });
  }
  @override
  void initState() {
    super.initState();
    print('User is ${widget.user.phoneNumber}');
    ideacount = 0;
    _dbobject=FirebaseFirestore.instance;
    const oneSec = const Duration(seconds:1);
    _timer= Timer.periodic(oneSec, (Timer t) => setIdeaCount());
  }
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  Widget buildBottomSheet(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: AddTaskWidget()));
  }
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        SystemNavigator.pop();
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Icon(
              FontAwesomeIcons.thinkPeaks,
                  color: kthemecolour,
              size: 40,
            ),
          ),
          backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.menu, size: 40,color: kthemecolour,), // change this size and style
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
        ),
        key: _scaffoldKey,
        drawer: SideNavigation(widget.user.phoneNumber),

        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 50,
          ),
          backgroundColor: Color(0XFFFDC57E),
          onPressed: (){
            showModalBottomSheet(context: context, builder: buildBottomSheet);
          },
        ),
        backgroundColor: Color(0XFFFDC57E),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Track your Ideas',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Lora',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '$ideacount ideas',
                    style: kideastyle,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35)),
                    color: Colors.white,
                    border: Border.all(style: BorderStyle.solid,
                        color: Colors.black12),
                  boxShadow:[ BoxShadow(
                    color: Colors.white70.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 12,
                    offset: Offset(0, 3), // changes position of shadow
                  ),]
                ),
                child:
               StreamBuilder<QuerySnapshot>(
                    stream: _dbobject.collection('ideacollection').orderBy('priority').where('user',isEqualTo:widget.user.phoneNumber).snapshots(),
                    builder: (context,snapshot){
                      if(!snapshot.hasData)
                      {
                        return Center(
                          child: CircularProgressIndicator(
                          ),
                        );
                      }
                      final ideadoc=snapshot.data.docs;
                      ideas=[];
                      for (var idea in ideadoc)
                      {
                        Map<String, dynamic> ideavar=idea.data();
                         ideas.add(IdeaList(ideavar['idea'],ideavar['priority'],idea.id));
                      }
                return ListView(children: ideas);
                    },
                  ),
                )
              ),
          ],
        ),
      ),
    );
  }
}



