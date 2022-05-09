
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:placement_cell_app/providers/authProvider.dart';
import 'package:placement_cell_app/services/user_profile.dart';
import 'package:placement_cell_app/utils/errorCallback.dart';
import 'package:provider/provider.dart';
class BuildUploadDocuments extends StatefulWidget {
  const BuildUploadDocuments({
    Key? key,required this.nextInfo}) : super(key: key);
  final Function nextInfo;

  @override
  State<BuildUploadDocuments> createState() => _BuildUploadDocumentsState();
}

class _BuildUploadDocumentsState extends State<BuildUploadDocuments> {
 bool _loading = false;

   File? imageFile ,resumeFile;
    String? imageFileName ,resumeFileName;
     Future uploadFile() async {
        // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.image);

    // if no file is picked
    if (result == null ) return;

    // we get the file from result object
    if(result.files.first.path==null) return;
     
    setState(() {
      imageFile = File(result.files.first.path!);
      imageFileName = result.files.first.name;      
    });
    
    
  }
       Future uploadFileResume() async {
        // you can also toggle "allowMultiple" true or false depending on your need
    final result = await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.any);

    // if no file is picked
    if (result == null ) return;

    // we get the file from result object
    if(result.files.first.path==null) return;
     
    setState(() {
      resumeFile = File(result.files.first.path!);
      resumeFileName = result.files.first.name;      
    });
    
    
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Upload Documents",
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            uploadFile();
          },
          child: Text("Upload Image",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
        ),
        Text(imageFileName ?? "",),
        SizedBox(height: 30,),
        ElevatedButton(
          onPressed: () {
            uploadFileResume();
          },
          child: Text("Upload Resume",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
        ),
       
        Text(resumeFileName ?? "",),
        SizedBox(height: 100,),
         Container(
            width: double.infinity,
            padding: EdgeInsets.all(30),
            height: 100,
            child: ElevatedButton(
                onPressed: () {
                  if(imageFile ==null || resumeFile == null){
                    toastMesssage("Please the Uplaoad the Required Documents");
                  }else{
                    setState(() {
                      _loading = true;
                    });
                    UserProfileService().updatDocuments(resumeFileName!, imageFileName!,resumeFile!, imageFile!, (e)=>toastMesssage(e), Provider.of<AuthProvider>(context,listen: false).userId).then((value){
                      if(value){
                            setState(() {
                   _loading = false;
                 });
                        Navigator.pop(context);
                      }
                    });
                  }
             
                },
                child: !_loading
                    ? const Text(
                        "Save & Continue",
                        style: TextStyle(fontSize: 20),
                      )
                    : Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white,),
                        ),
                      )))
      ],
    );
  }
}
