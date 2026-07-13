import 'package:book_reminder/core/database/app_database.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppDatabase.database;
  
  runApp(const BookReminderApp());
}
