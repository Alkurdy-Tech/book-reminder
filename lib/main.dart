import 'package:flutter/material.dart';
import 'package:flutter_application_1/fbook.dart';
import 'package:flutter_application_1/nextbook.dart';
import 'package:flutter_application_1/screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     title: 'Named Routes Demo',
  // Start the app with the "/" named route. In this case, the app starts
  // on the FirstScreen widget.
  initialRoute: '/Screen',
  routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    '/Screen': (context) => const Screen(),
    // When navigating to the "/second" route, build the SecondScreen widget.
    '/Nextbook': (context) => const Nextbook(),
    '/Fbook': (context) => const Fbook(),
  },


    );
  }
} 
