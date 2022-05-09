import 'package:firebase_auth/firebase_auth.dart' as auth; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:flutter/material.dart';
import 'package:placement_cell_app/firebase_options.dart';
import '../models/user_profile.dart';

import 'package:google_sign_in/google_sign_in.dart';



enum ApplicationLoginState {
  loggedOut,
  loggedIn,
}

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    init();
  }
  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  late String _userId;
  String get userId => _userId;
  late String _email;
  String get email => _email;
  late String _docId;
  setDocID(String docId) {
    _docId = docId;
    notifyListeners();
  }
  int _appliedJobs = 0;
  int get appliedJob =>_appliedJobs;
  setAppliedJobs(size){
    _appliedJobs = size;
    notifyListeners();

  }
  int _OngoingJobs = 0;
    int get OngoingJobs =>_appliedJobs;
  setOngoingJobs(size){
    _OngoingJobs = size;
    notifyListeners();

  }


  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
   if (Firebase.apps.isEmpty) {
  await Firebase.initializeApp(
 
  options: DefaultFirebaseConfig.platformOptions,
 ).whenComplete(() {
  print("completedAppInitialize");
 });
}
    print("listening to changes");
    auth.FirebaseAuth.instance.userChanges().listen((userAuth) {
      print("user auth changes${userAuth != null}");
      if (userAuth != null) {
        _userId = userAuth.uid;
        _email = userAuth.email!;
      _loginState = ApplicationLoginState.loggedIn;
      print("user exist");
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        print("user does not exit");
      }
    });
    notifyListeners();
  }


  Future<void> signout() async {
    await auth.FirebaseAuth.instance.signOut();
    _loginState = ApplicationLoginState.loggedOut;
    //await GoogleSignIn().signOut();
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(auth.FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var credential =
          await auth.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(credential.user!.displayName);
      _userId = credential.user!.uid;
      _email = credential.user!.email!;
      _loginState = ApplicationLoginState.loggedIn;
    } on auth.FirebaseAuthException catch (e) {
      errorCallback(e);
    }
    notifyListeners();
  }

  // Future<void> signUpWithEmailAndPassword(String email, String displayName,
  //     String password, void Function(String e) errorCallback) async {
  //   try {
  //     var credential = await auth.FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     await credential.user!.updateDisplayName(displayName);
  //     _currentUser = User(email: credential.user!.email!,userId: credential.user!.uid,userName: credential.user!.displayName,image: credential.user!.photoURL);
  //     _loginState = ApplicationLoginState.loggedIn;
  //   } on auth.FirebaseAuthException catch (e) {
  //     errorCallback(e.code);
  //   }

  //   notifyListeners();
  // }
}
