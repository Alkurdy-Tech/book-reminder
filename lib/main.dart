
import 'package:book_reminder/auth/login_screen.dart';
import 'package:book_reminder/database/app_database.dart';
import 'package:book_reminder/home.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final dbPath = await getDatabasesPath();
  final savedEmail = await AppDatabase.instance.getSavedEmail();
  print("DATABASE LOCATION: $dbPath");
  print("SAVED EMAIL: $savedEmail");
  runApp(MyApp(startLoggedIn: savedEmail != null));
}

class MyApp extends StatelessWidget {
  final bool startLoggedIn;
  const MyApp({super.key, required this.startLoggedIn});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:startLoggedIn ? homepage() : LoginScreen(), );

    
  }
} 
