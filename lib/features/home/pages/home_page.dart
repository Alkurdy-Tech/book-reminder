import 'package:book_reminder/features/home/widget/home_header.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Column(
      children: [
        HomeHeader(),
        // Search_Bar(),
        // ProgressBar(),
        // sectionTitle(),
        // ReminderCard(),
        // SectionTitle(),
        // BookCard(),
      ]
    ));
  }
}
