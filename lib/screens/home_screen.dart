import 'package:flutter/material.dart';
import 'package:placement_cell_app/constants/colors.dart';
import 'package:placement_cell_app/providers/authProvider.dart';
import 'package:placement_cell_app/screens/main_screen.dart';
import 'package:placement_cell_app/screens/my_jobs_screen.dart';
import 'package:placement_cell_app/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  int _selectedIndex = 0;
   static  List<Widget> _widgetOptions = <Widget>[
    MainScreen(),    
    MyJobsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    
    return Scaffold(
    
      body:  _widgetOptions.elementAt(_selectedIndex),
       bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'My Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_sharp),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class signOUt extends StatelessWidget {
  const signOUt({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      child: ElevatedButton(
        child: Text("Sign out"),
        onPressed: () {
          Provider.of<AuthProvider>(context, listen: false).signout();
        },
      ),
    );
  }
}
