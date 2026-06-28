import 'package:book_reminder/features/home/widget/home_header.dart';
import 'package:book_reminder/features/home/widget/progress_card.dart';
import 'package:book_reminder/features/home/widget/search_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Column(
      children: [
        HomeHeader(),
        HomeSearchBar(),
        ReadingProgressCard(
          completedBooks: 7,                                                    // these values are hardcoded for now, but they will be dynamic in the future
          totalBooks: 10,
          quete: 'A reader lives a thousand lives',
        ),
        // sectionTitle(),
        // ReminderCard(),
        // SectionTitle(),
        // BookCard(),
      ]
    ));
  }
}
