import 'package:flutter/material.dart';
import 'package:idea_tracker/utilities/constants.dart';
import 'rounded_button.dart';
import 'package:idea_tracker/services/dbservice.dart';
import 'package:idea_tracker/components/selectpriority.dart';
class AddTaskWidget extends StatefulWidget {
  @override
  _AddTaskWidgetState createState() => _AddTaskWidgetState();
}
class _AddTaskWidgetState extends State<AddTaskWidget> {
  String selectedvalue='Normal';
  FireStoreDB db=FireStoreDB();
  String textvalue='';
  void setPriorityState(String value){
    setState(() {
      selectedvalue=value;
    });
  }
  int determinePriority(){
    switch(selectedvalue){
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
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Color(0XFF757575)),
            color: Color(0XFF757575)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            color: Colors.white,
            border: Border.all(style: BorderStyle.solid, color: Colors.black12),
          ),
          padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add your new idea!',
                textAlign: TextAlign.center,
                style: ktaskfontstyle,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value){
                  textvalue=value;
                },
                style: ktextfieldstyle,
              ),
              Center(
                child: SelectPriority(this.selectedvalue,this.setPriorityState),
              ),
              RoundedButton(
                  title: 'Add',
                  colour: kthemecolour,
                  onPressed: () async{
                  try{
                    await db.sendIdea(textvalue, determinePriority());
                  }
                  catch(e)
                    {
                      print(e);
                    }
                    Navigator.pop(context);
              })
            ],
          ),
        ),
      );
  }
}

