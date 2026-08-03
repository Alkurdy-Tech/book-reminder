import 'package:book_reminder/fbook.dart';
import 'package:book_reminder/screen.dart';
import 'package:book_reminder/setting.dart';

import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final GlobalKey<ScreenState> screenKey = GlobalKey<ScreenState>();
  final List page = [Screen(), Fbook(),SettingsScreen()];
  int indexpage = 0;
  void convertpage(int index) {
    setState(() {
      indexpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            margin: EdgeInsets.all(5),
            child: Center(
              child: const Text(
                "My Reading Journal",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 237, 241, 236),
        ),
        body: page[indexpage],
        bottomNavigationBar: SizedBox(
          height: 69,
          child: BottomNavigationBar(
            backgroundColor: Color(0xFF4F8A49),
            currentIndex: indexpage,
            onTap: convertpage,
            selectedItemColor: const Color.fromARGB(
              255,
              239,
              241,
              241,
            ), // color when tab is selected
            unselectedItemColor: const Color.fromARGB(
              255,
              214,
              211,
              211,
            ), // color when tab is not selected
            selectedFontSize: 18, // size when selected
            unselectedFontSize: 15, // size when not selected
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu_book_rounded,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 25,
                ),
                label: "reading",
              ),

              BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_circle_rounded,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 25,
                ),
                label: "finshed",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 25,
                ),
                label: "Setting",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
