

import 'package:flutter/material.dart';
import 'package:placement_cell_app/routes/arguments.dart';
import 'package:placement_cell_app/screens/create_profile_screen.dart';
import 'package:placement_cell_app/screens/home_screen.dart';
import 'package:placement_cell_app/screens/job_details.screen.dart';
import 'package:placement_cell_app/screens/profile_screen.dart';
import 'package:placement_cell_app/screens/sign_in_screen.dart';
import 'package:placement_cell_app/screens/view_all_jobs_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
 "/home" :(BuildContext context) => HomeScreen(),
 '/signin':(BuildContext context) => SignInScreen(),
 '/creatProfile':(BuildContext context) => CreateProfileScreen(),
 '/viewAll':(BuildContext context) => ViewAllJobsScreen(),
 '/jobDetails':(BuildContext context) => JobDetailsScreen(),
  //"/": (BuildContext context) => SplashScreen(),
 // "/": (BuildContext context) => SignUpScreen (),
   


};