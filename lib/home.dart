import 'package:book_reminder/fbook.dart';
import 'package:book_reminder/screen.dart';
import 'package:book_reminder/setting.dart';
import 'package:flutter/material.dart';
import 'main.dart'; // for accentColorNotifier

class homepage extends StatefulWidget {
  homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final GlobalKey<ScreenState> screenKey = GlobalKey<ScreenState>();
  final List page = [Screen(), Fbook(), SettingsScreen()];
  int indexpage = 0;

  void convertpage(int index) {
    setState(() {
      indexpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ❌ removed MaterialApp — just return the Scaffold directly
    return ValueListenableBuilder<Color>(
      valueListenable: accentColorNotifier,
      builder: (context, accentColor, _) {
        return Scaffold(
          appBar: AppBar(
            title: Container(
              margin: EdgeInsets.all(5),
              child: Center(
                child: const Text(
                  "My Reading Journal",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            backgroundColor: accentColor, // <-- now dynamic
          ),
          body: page[indexpage],
          bottomNavigationBar: SafeArea(
            child: SizedBox(
              height: 69,
              child: BottomNavigationBar(
                backgroundColor: accentColor, // <-- now dynamic
                currentIndex: indexpage,
                onTap: convertpage,
                selectedItemColor: const Color.fromARGB(255, 239, 241, 241),
                unselectedItemColor: const Color.fromARGB(255, 214, 211, 211),
                selectedFontSize: 18,
                unselectedFontSize: 15,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_book_rounded, color: Colors.white, size: 25),
                    label: "reading",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_rounded, color: Colors.white, size: 25),
                    label: "finshed",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings, color: Colors.white, size: 25),
                    label: "Setting",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}