import 'package:book_reminder/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';

class BookReminderApp extends StatelessWidget {
  const BookReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Reminder',
      debugShowCheckedModeBanner: false,
      home: const HomePage()
    );
  }
}