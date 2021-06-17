import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:idea_tracker/services/dbservice.dart';
import 'package:idea_tracker/components/updatetask.dart';
import 'package:idea_tracker/services/uploadfiles.dart';
import 'package:idea_tracker/services/getcloudfiles.dart';
import 'package:idea_tracker/utilities/constants.dart';
import 'package:idea_tracker/screens/viewfiles.dart';

class IdeaList extends StatelessWidget {
  final int priority;
  final String ideatext;
  final FireStoreDB _db=FireStoreDB();
  final String documentID;
  final SnackBar successfulUpload= SnackBar(content: Text('File Successfully Uploaded!',style: ksidetextstyle,),
    backgroundColor: kthemecolour,);
  final SnackBar uploadFailed= SnackBar(content: Text('File upload Failed',style: ksidetextstyle,),
    backgroundColor: kthemecolour,);
  IdeaList(this.ideatext,this.priority,this.documentID);
  Color getColor()
  {
    if(priority==1)
      return Colors.red;
    else if(priority==2)
      return Colors.amberAccent;
    else
      return Colors.green;
  }
  String getPriority()
  {
    if(priority==1)
      return 'High';
    else if(priority==2)
      return 'Normal';
    else
      return 'Low';
  }
  Widget buildBottomSheet(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: UpdateTask(getPriority(),ideatext,documentID)));
  }
  @override
  Widget build(BuildContext context) {

    return Slidable(
      actionPane: SlidableScrollActionPane(),
      actions: [
        IconSlideAction(
          caption: 'Delete',
          color: Colors.redAccent,
          icon: Icons.delete_forever_rounded,
          onTap: (){
            print('Going to delete item');
          //  print(documentID);
            try {
              _db.deleteIdea(documentID);
            }
            catch(e){
              print(e);
            }
          },
        ),
        IconSlideAction(
          caption: 'Update',
          color: Colors.amberAccent,
          icon: Icons.update,
            onTap:(){
            print('Going to update');
            showModalBottomSheet(context: context, builder: buildBottomSheet);
    }
        ),
        IconSlideAction(
            caption: 'Attachments',
            color: Colors.deepOrangeAccent,
            icon: Icons.attachment_rounded,
            onTap:()async{
              print('Pressed attachments');
              final GetCloudFiles gt=GetCloudFiles(ideatext);
              List<String> fileNames=await gt.getFileNames();
              for(int i=0;i<fileNames.length;i++)
                {
                  print('Retrieved file: ${fileNames[i]}');
                }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewFiles(
                        ideatext,
                      )));
            }
        ),
        IconSlideAction(
            caption: 'Upload',
            color: Colors.deepPurple,
            icon: Icons.cloud_upload,
            onTap:()async{
              final UploadFiles storage=UploadFiles(documentID,ideatext);
              bool fileSent=await storage.getPdfAndUpload();
              print('File sent status is $fileSent');
              if(fileSent)
                ScaffoldMessenger.of(context).showSnackBar(successfulUpload);
              else
                ScaffoldMessenger.of(context).showSnackBar(uploadFailed);
            }
        )
      ],
      actionExtentRatio: 1/4,
      child: ListTile(
        title: Text(ideatext,
          style: TextStyle(
              fontSize: 20
          ),),
        trailing: Icon(Icons.circle,
            color: getColor()),
          ),
    );
  }
}