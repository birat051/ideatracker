import 'package:flutter/material.dart';
import 'package:idea_tracker/services/getcloudfiles.dart';
import 'package:idea_tracker/components/cloudfiles.dart';
import 'package:idea_tracker/utilities/constants.dart';
import 'dart:async';

class ViewFiles extends StatefulWidget {
  final String ideatext;
  ViewFiles(this.ideatext);
  @override
  _ViewFilesState createState() => _ViewFilesState();
}

class _ViewFilesState extends State<ViewFiles> {
  List<String> fileNames=[];
  List<CloudList> cloudlist=[];
  var _timer;
  void setList(){
    setState(() {
      cloudlist;
    });
  }
  Future<List<String>> getFiles() async{
    final GetCloudFiles gt=GetCloudFiles(widget.ideatext);
    fileNames=await gt.getFileNames();
    return fileNames;
  }
  @override
  void initState() {
    super.initState();
    const oneSec = const Duration(seconds:1);
    _timer= Timer.periodic(oneSec, (Timer t) => setList());
  //  getCloudFiles();
  }
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.ideatext)),
        backgroundColor: kthemecolour,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child:
        /* ListView(
          children: cloudlist,
        ), */
      FutureBuilder(
          future: getFiles(),
          builder: (BuildContext context,AsyncSnapshot snapshot){
            if(!snapshot.hasData)
              return Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(70,0,70,0),
                  child: LinearProgressIndicator(),
                ),
              );
            return ListView.builder(itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context,int index){
              return CloudList(snapshot.data[index]);
            },
            );
          },
      ),
    ),
    );
  }
}
