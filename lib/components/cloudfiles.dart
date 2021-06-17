import 'package:flutter/material.dart';
import 'package:idea_tracker/utilities/constants.dart';
import 'package:idea_tracker/services/deleteanddownloadfiles.dart';

class CloudList extends StatelessWidget {
  final String filename;
  CloudList(this.filename);
  final SnackBar successfulDelete = SnackBar(
    content: Text(
      'File Successfully Deleted',
      style: ksidetextstyle,
    ),
    backgroundColor: kthemecolour,
  );
  final SnackBar deleteFailed = SnackBar(
    content: Text(
      'Could\'nt delete file',
      style: ksidetextstyle,
    ),
    backgroundColor: kthemecolour,
  );
  final SnackBar downloadFailed = SnackBar(
      content: Text(
        'File could\'nt be downloaded',
        style: ksidetextstyle,
      ),
      backgroundColor: kthemecolour);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        leading: GestureDetector(
          child: Icon(
            Icons.download,
            color: Colors.white,
            size: 30,
          ),
          onTap: () async {
            DeleteandDownloadFiles downloadObject =
                DeleteandDownloadFiles(filename);
            bool downloadstatus = await downloadObject.downloadFile();
            print('Download status is: $downloadstatus');
            if(!downloadstatus)
              ScaffoldMessenger.of(context).showSnackBar(downloadFailed);
          },
        ),
        title: Text(
          filename.split('/')[2],
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        tileColor: kthemecolour,
        trailing: GestureDetector(
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 30,
          ),
          onTap: () async {
            DeleteandDownloadFiles downloadObject =
                DeleteandDownloadFiles(filename);
            bool deletestatus = await downloadObject.deletefromStorage();
            print('File deleted status is: $deletestatus');
            deletestatus?ScaffoldMessenger.of(context).showSnackBar(successfulDelete):ScaffoldMessenger.of(context).showSnackBar(deleteFailed);
          },
        ),
      ),
    );
  }
}
