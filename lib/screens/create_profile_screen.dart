import 'package:flutter/material.dart';
import 'package:placement_cell_app/components/build_education_info.dart';
import 'package:placement_cell_app/components/build_personal_info.dart';
import 'package:placement_cell_app/components/build_skillset.dart';
import 'package:placement_cell_app/components/build_upload_documents.dart';

class CreateProfileScreen extends StatefulWidget {
  CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
   int _index = 0;

  nextInfo(){
    setState(() {
      if(_index == 3){
        Navigator.of(context).pop();
      }else{
         _index++;
      }
     
    });
  }
  @override
  Widget build(BuildContext context) {
   MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                if(_index == 0){
        Navigator.of(context).pop();
      }else{
         _index--;
      }
     
              });
            },
          ),
          centerTitle: true,
          title: Text(
            "Complete Profile",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          height: queryData.size.height,
          width: queryData.size.width,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildProfileIndicator(queryData),
                  IndexedStack(
                    index: _index,
                    children: [
                     BuildPersonalInfo(nextInfo: nextInfo),
                      BuildEducationInfo(nextInfo: nextInfo),
                      BuildSkillSet(nextInfo: nextInfo),
                      BuildUploadDocuments(nextInfo: nextInfo,)
                    ],
                  ),
                  // buildEducationInfo(queryData)
                 
                ]),
          ),
        ));
  }

 
  


  Center buildProfileIndicator(MediaQueryData queryData) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Row(
          children: [
            //Icon(Icons.circle,color: Colors.blue,),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.blue),
            ),
            SizedBox(
                width: queryData.size.width * 0.2,
                child: Divider(
                  thickness: 3,
                  color: _index >= 0 ? Colors.blue : Colors.black12,
                )),
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.blue),
            ),
            SizedBox(
                width: queryData.size.width * 0.2,
                child: Divider(
                  thickness: 3,
                  color: _index >= 1 ? Colors.blue : Colors.black12,
                )),

            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.blue),
            ),
            SizedBox(
                width: queryData.size.width * 0.2,
                child: Divider(
                  thickness: 3,
                  color: _index >= 2 ? Colors.blue : Colors.black12,
                )),

            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.blue),
            ),
            SizedBox(
                width: queryData.size.width * 0.2,
                child: Divider(
                  thickness: 3,
                  color: _index >= 3 ? Colors.blue : Colors.black12,
                )),

            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}