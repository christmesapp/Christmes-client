import 'package:christmes/misc/colors.dart';
import 'package:christmes/screens/homePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';


class HamburgerMenu extends StatelessWidget {
  static const bluecolor = Color(0xff2e6ca4);
  static const whitecolor = Color(0xfffafafa);
  var _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[

    Center(
        child: HomePage()
    ),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Menü"),

        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(color: bluecolor),

      ),
      body:  Center(
        child: _pages[_selectedIndex],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: whitecolor,
              ),
              child: Image(image: AssetImage('../img/christmes_logo_02.png')),
              //Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('1'),
              onTap: () {
                //onTap
                _selectedIndex = 1;
                print (_selectedIndex);


              },
            ),
            ListTile(
              title: const Text('2'),
              onTap: () {
                //onTap
                _selectedIndex = 2;
                print (_selectedIndex);

              },
            ),
            ListTile(
              title: const Text('3'),
              onTap: () {
                //onTap
                _selectedIndex = 3;


              },
            ),
          ],
        ),
      ),
     ),
    );
  }
}