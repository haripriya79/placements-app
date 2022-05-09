import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toastMesssage(String msg){
     return Fluttertoast.showToast(  
        msg: msg,  
        toastLength: Toast.LENGTH_SHORT,  
        gravity: ToastGravity.BOTTOM,  
        timeInSecForIosWeb: 8,
          
        backgroundColor: Colors.grey,
        ); 
          
  }
   errorCallbackSignUp(e){
    String msg = "";
  if (e == 'weak-password') {
    msg = 'The password provided is too weak.';
    print('The password provided is too weak.');
  } else if (e == 'email-already-in-use') {
    print("hii");
    msg = 'The account already exists for that email.';   
    print('The account already exists for that email.');
  }
  toastMesssage(msg);
  
  }
  errorCallbackSignIn(e){
    String msg = "";
     if (e== 'user-not-found') {
    msg = 'No user found for that email.';
  } else if (e == 'wrong-password') {
    msg = 'Wrong password provided for that user.';
  }else{
    msg = "Invalid UserName and Password";
  }

  toastMesssage(msg);
  
  }