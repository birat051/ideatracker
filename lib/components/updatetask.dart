import 'package:flutter/material.dart';
import 'package:idea_tracker/utilities/constants.dart';
import 'rounded_button.dart';
import 'package:idea_tracker/services/dbservice.dart';
import 'package:idea_tracker/components/selectpriority.dart';

class UpdateTask extends StatefulWidget {
  final String value;
  final String text;
  final String documentID;
  @override
  UpdateTask(this.value,this.text,this.documentID);
  _UpdateTaskState createState() => _UpdateTaskState();
}
class _UpdateTaskState extends State<UpdateTask> {
  String selectedvalue;
  FireStoreDB db=FireStoreDB();
  String textvalue='';
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
  void setPriorityState(String value){
    setState(() {
      selectedvalue=value;
    });
  }
  String sendText(){
    if (textvalue=='')
      return widget.text;
    else
      return textvalue;
  }
  @override
  void initState() {
    super.initState();
    selectedvalue=widget.value;
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
              decoration: InputDecoration(
                hintText: widget.text,
                hintStyle: ktextfieldstyle,
              ),
              style: ktextfieldstyle,
            ),
            Center(
              child: SelectPriority(this.selectedvalue,this.setPriorityState),
            ),
            RoundedButton(
                title: 'Update',
                colour: kthemecolour,
                onPressed: () async{
                  try{
                    await db.updateIdea(widget.documentID, sendText(), determinePriority());
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
