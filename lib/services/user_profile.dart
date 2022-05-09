

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:placement_cell_app/firebase_options.dart';
import 'package:placement_cell_app/models/education_profile.dart';
import 'package:placement_cell_app/models/personal_profile.dart';
import 'package:placement_cell_app/models/user_profile.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// void main() {
  
//     print("listening to changes");
//     UserProfile user = UserProfile(userId: "leJvJkqvvAS1bk2F7lffyEMn1zR2", personalProfile: PersonalProfile(address: "18/1/482",dateOfBirth: "15",gender: "Female",mobileNumber: 123456780,name: "Gangavaram Haripriya"));
//     EducationProfile edu = EducationProfile(branch: "CSE1", year:3, cgpa: 8.6, course: "B-Tech", passingYear:DateTime.now().year);
//     callBackError(e){
//       print(e);
//     }
    
//     //UserProfileService().createUserProfile(user, callBackError);
//     UserProfileService().updateEducationProfile(edu, callBackError, "leJvJkqvvAS1bk2F7lffyEMn1zR2");
//     //UserProfileService().updatSkillSet(["C++","python"], callBackError, 'GYHRBdn9CY08MVLvWt8z');
// }

class UserProfileService{


  // Future<UserProfile> getUserProfile(String userId){


  // }
  Future<bool> createUserProfile(UserProfile profile,Function callBackError)async{
     WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
     CollectionReference<Map<dynamic, dynamic>> usersProfileRef =
        FirebaseFirestore.instance.collection('userProfiles');
    bool _flag = false;
    print("function set user");
    try{
     await usersProfileRef
        .add(profile.toJson())
        .then((value) => {
              //getting the user if exists
            _flag = true,
            print(value),


              
        });
    }catch(e){
      print("error");
      print(e);
      callBackError(e);     

    }

       print("flag:$_flag");
    return _flag;

  }
  Future<bool> updateEducationProfile(EducationProfile profile , Function callBackError,userId) async{
      WidgetsFlutterBinding.ensureInitialized();
     //await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
     CollectionReference<Map<dynamic, dynamic>> usersProfileRef =
        FirebaseFirestore.instance.collection('userProfiles');
    bool _flag = false;
    print("function set user");
    try{
      
      var doc =  await usersProfileRef.where('userId', isEqualTo: userId).get();
      var documnet = doc.docs.first;
      print(documnet.id);
       await usersProfileRef.doc(documnet.id)
        .update({
          'educationProfile':profile.toJson(),
        }).then((value)  {
           _flag = true;
        });
      



        
    }catch(e){
      print("error");
      print(e);
      callBackError(e);     

    }

       print("flag:$_flag");
    return _flag;


  }
    Future<bool> updatSkillSet(List<String> skills , Function callBackError,userId) async{
      WidgetsFlutterBinding.ensureInitialized();
     //await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
     CollectionReference<Map<dynamic, dynamic>> usersProfileRef =
        FirebaseFirestore.instance.collection('userProfiles');
    bool _flag = false;
    print("function set user skills");
    print(skills);
    try{
       var doc =  await usersProfileRef.where('userId', isEqualTo: userId).get();
      var documnet = doc.docs.first;
      print(documnet.id);
     await usersProfileRef.doc(documnet.id)
        .update({
          'skillSet':skills,
        }).then((value)  {
           _flag = true;
           

        });
        
        
    }catch(e){
      print("error");
      print(e);
      callBackError(e);     

    }

       print("flag:$_flag");
    return _flag;


  }
      Future<bool> updatDocuments(String resumeName,String imageName,File resumeFile,File imageFile, Function callBackError,userId) async{
      WidgetsFlutterBinding.ensureInitialized();
     //await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
     
     CollectionReference<Map<dynamic, dynamic>> usersProfileRef =
        FirebaseFirestore.instance.collection('userProfiles');
    bool _flag = false;
    print("function set user");
    try{

      String image = await uploadFile(imageName, imageFile);
      String resume = await uploadFile(resumeName, resumeFile);
       var doc =  await usersProfileRef.where('userId', isEqualTo: userId).get();
      var documnet = doc.docs.first;
      print(documnet.id);
     await usersProfileRef.doc(documnet.id)
        .update({
          'image':image,
          'resume':resume
        }).then((value)  {
           _flag = true;
           

        });
        
        
    }catch(e){
      print("error");
      print(e);
      callBackError(e);     

    }

       print("flag:$_flag");
    return _flag;


  }
     Future<String> uploadFile(fileName,File file) async {
    
       WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseConfig.platformOptions
    // );
     firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
    if (file == null) return "";
    
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      firebase_storage.TaskSnapshot
       task =   await ref.putFile(file );
      String _url =   await task.ref.getDownloadURL();
      return _url;
    } catch (e) {
      print(e);
      print('error occured');
    }
     return "";
  }
  Future<void> downloadFileExample(url) async {
  //First you get the documents folder location on the device...
  Directory appDocDir = await getApplicationDocumentsDirectory();
  //Here you'll specify the file it should be saved as
  File downloadToFile = File('${appDocDir.path}/resume.pdf');
  //Here you'll specify the file it should download from Cloud Storage
  String fileToDownload = 'uploads/resumepdf.pdf';

  //Now you can try to download the specified file, and write it to the downloadToFile.
  try {
    await firebase_storage.FirebaseStorage.instance
        .refFromURL(url)
        .writeToFile(downloadToFile);
    OpenFile.open(downloadToFile.path);
  } on FirebaseException catch (e) {
    // e.g, e.code == 'canceled'
    print('Download error: $e');
  }
}
 Stream<QuerySnapshot> userProfileStream(userId) {
    return FirebaseFirestore.instance
        .collection('userProfiles')
        .where('userId', isEqualTo: userId)
        .snapshots();
  }
 
  


  }
  
