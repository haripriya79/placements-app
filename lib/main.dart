import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:placement_cell_app/screens/home_screen.dart';
import 'package:placement_cell_app/providers/authProvider.dart';
import 'package:placement_cell_app/routes/routes.dart';
import 'package:placement_cell_app/screens/sign_in_screen.dart';
import 'package:placement_cell_app/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
         debugShowCheckedModeBanner: false,
        title: 'Placement Cell App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.lato().fontFamily,
        ),
        home: Consumer<AuthProvider>(
          builder: (context, appState, child) {
            if (appState.loginState == ApplicationLoginState.loggedIn) {
              return HomeScreen();
            } else {
              return SignInScreen();
            }
          },
        ),
        routes: routes,
      ),
    );
  }
}
