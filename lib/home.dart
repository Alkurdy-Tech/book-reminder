import 'package:book_reminder/addbook.dart';
import 'package:book_reminder/fbook.dart';
import 'package:book_reminder/nextbook.dart';
import 'package:book_reminder/screen.dart';
import 'package:flutter/material.dart';
import 'widget/book_card.dart';

class homepage extends StatefulWidget {
  homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final List page = [Screen(), Nextbook(), Fbook()];
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
            child: const Text(
              "My Reading Journal",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                showDialog(context: context, builder: (context) => Addbook());
              },
              child: Row(
                children: [
                  Icon(Icons.add, color: Color.fromARGB(255, 230, 76, 0)),
                  Text(
                    "ADD",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight(600),
                    ),
                  ),
                ],
              ),
            ),
          ],
          backgroundColor: Colors.deepOrange,
        ),
        body: page[indexpage],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.deepOrange,
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
                size: 30,
              ),
              label: "reading",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books_rounded,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 30,
              ),
              label: "next",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.check_circle_rounded,
                color: Color.fromARGB(255, 255, 255, 255),
                size: 30,
              ),
              label: "finshed",
            ),
          ],
        ),
      ),
    );
  }
}
