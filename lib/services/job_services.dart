import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:placement_cell_app/firebase_options.dart';
import 'package:placement_cell_app/models/jobs.dart';
import 'package:placement_cell_app/models/user_profile.dart';
import 'package:placement_cell_app/utils/errorCallback.dart';

// void main() {
//   print("listening to changes");
//   Jobs job = Jobs(
//       companyName: "Amazon",
//       role: "Software Engineer",
//       package: "15",
//       description: '''
//     The focus we have on our customers is why we are one of the world’s most beloved brands – customer obsession is part of our company DNA. Our Software Development Engineers (SDEs) use cutting-edge technology to solve complex problems and get to see the impact of their work first-hand. The challenges SDEs solve for at Amazon are big and influence millions of customers, sellers, and products around the world. We are looking for individuals who are passionate about creating new products, features, and services from scratch while managing ambiguity and the pace of a company where development cycles are measured in weeks, not years. If this sounds interesting to you, apply and come chart your own path at Amazon.
// By applying to this position your application will be considered for all locations we hire for in India. This includes but is not limited to Bengaluru, Chennai, Hyderabad, Delhi and Pune. To qualify, applicants should have earned a Bachelor’s or Master’s degree, and graduate in 2022.
//     ''',
//       lastDate: "11 July 2022",
//       active: true,
//       type: "Ongoing",
//       eligibilityCriteria: '''
// • Currently enrolled in a Bachelor’s or Master’s Degree in Computer Science, Computer Engineering, or related field at time of application
// • Familiarity with the syntax of languages such as Java, C/C++ or Python.
// • Knowledge of Computer Science fundamentals such as object-oriented design, algorithm design, data structures, problem solving, and complexity analysis.
// ''',
//       location: "Bangalore",
//       requiredSkills: '''
// • Previous technical internship(s).
// • Experience with distributed, multi-tiered systems, algorithms, and relational databases.
// • Experience in optimization mathematics such as linear programming and nonlinear optimization.
// • Effectively articulate technical challenges and solutions.
// • Adept at handling ambiguous or undefined problems as well as ability to think abstractly.
// ''');
//   Jobs job1 = Jobs(
//       companyName: "Zoho Crop",
//       role: " Member Technical Staff - Software Developer",
//       package: '''
// 5.6 L
// 7 L L
// 8.4 L ''',
//       description: '''' 
// Researching, designing, implementing, and managing software programs
// Contribute in all phases of the product development life cycle
// Write well-designed, testable and efficient code
// Ensure designs are in compliance with specifications
// Support continuous improvement by investigating alternatives and technologies and presenting these for architectural review
// ''',
//       lastDate: "09/03/2022",
//       active: true,
//       type: "Ongoing",
//       location: "Chennai",
//       eligibilityCriteria: '''
// We do not have any criteria, students from any stream/department (UG/PG) even with Backlogs can appear for the test. Passion towards programming is our only criteria. 
// ''',
//       requiredSkills: '''
// Excellent knowledge in Data structure, AI Algorithms and Machine learning.
// Proficiency in any of these modern programming language such as C, C++, Java
// Good knowledge of any of the Relational Databases: MySQL or PostgreSQL.
// Added advantage of having knowledge in the technologies like HTML, Java script, AJAX, CSS, JQuery or using frameworks any like Angular, React etc
// Good in problem-solving, Communication and analytical 
// ''');
//   JobServices().addJobs(job1, (e) => toastMesssage(e));
//   //UserProfileService().createUserProfile(user, callBackError);
//   //UserProfileService().updateEducationProfile(edu, callBackError, "leJvJkqvvAS1bk2F7lffyEMn1zR2");
//   //UserProfileService().updatSkillSet(["C++","python"], callBackError, 'GYHRBdn9CY08MVLvWt8z');
// }

class JobServices {
  Future<bool> addJobs(Jobs job, Function callBackError) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseConfig.platformOptions);
    CollectionReference<Map<dynamic, dynamic>> jobsRef =
        FirebaseFirestore.instance.collection('jobs');
    bool _flag = false;
    print("function set user");
    try {
      await jobsRef.add(job.toJson()).then((value) => {
            //getting the user if exists
            _flag = true,
            print(value),
          });
    } catch (e) {
      print("error");
      print(e);
      callBackError(e);
    }

    print("flag:$_flag");
    return _flag;
  }

  Future<bool> applyJobs(
      String jobId, String userId, Function callBackError) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseConfig.platformOptions);
    CollectionReference<Map<dynamic, dynamic>> jobsRef =
        FirebaseFirestore.instance.collection('jobs');
    CollectionReference<Map<dynamic, dynamic>> usersProfileRef =
        FirebaseFirestore.instance.collection('userProfiles');
    bool _flag = false;
    print("function set user");
    try {
      var _firestore = FirebaseFirestore.instance;

      //get the userData
      var doc = await usersProfileRef.where('userId', isEqualTo: userId).get();
      var documnet = doc.docs.first;

      print(documnet.id);
      await usersProfileRef.doc(documnet.id).update({
        'appliedJobs': FieldValue.arrayUnion([jobId])
      }).then((value) {
        _flag = true;
      });

      await jobsRef.doc(jobId).update({
        'applied': FieldValue.arrayUnion([userId])
      }).then((value) {
        _flag = true;
      });
    } catch (e) {
      print("error");
      print(e);
      callBackError(e);
    }

    print("flag:$_flag");
    return _flag;
  }
}
