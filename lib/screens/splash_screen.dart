
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:placement_cell_app/providers/authProvider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key , required this.route}) : super(key: key);
  String route;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Timer(Duration(seconds: 3),
          ()=>Navigator.of(context).pushReplacementNamed('/${widget.route}'));
  }
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        height: queryData.size.height,
        width: queryData.size.width,
             
        child: Stack(children: [
          
          backgroundImageContainer(queryData.size.width, queryData.size.height),
           backgroundGradientContainer(queryData.size.width, queryData.size.height),
            BuildLogo()
         
        ]),
       
    
      ),
    );
  }

    backgroundImageContainer(cardWidth, cardHeight) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
       
        image: DecorationImage(
          image: AssetImage("assets/college.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  backgroundGradientContainer(cardWidth, cardHeight) {
    return Container(
      width: cardWidth,
      height: cardHeight,
      decoration: BoxDecoration(
        
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.6),           
            Colors.black.withOpacity(0.6),
          ],
          begin: Alignment.topCenter,
          end: Alignment(0.0,1),
        ),
      ),
    );
  }
}

class BuildLogo extends StatelessWidget {
  const BuildLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [Image.asset("assets/jntua_logo.png",),
        Text("JNUTA \n Placements Cell",style: TextStyle(fontSize: 34,color: Colors.white,fontWeight: FontWeight.w500),textAlign: TextAlign.center,) ,]),
    );
  }
}