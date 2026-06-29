import 'package:book_reminder/features/home/widgets/home_header.dart';
import 'package:book_reminder/features/home/widgets/progress_card.dart';
import 'package:book_reminder/features/home/widgets/search_bar.dart';
import 'package:book_reminder/features/home/widgets/upcoming_reminder.dart';
import 'package:book_reminder/features/home/widgets/your_library_section.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: const [
            HomeHeader(),
            HomeSearchBar(),
            ReadingProgressCard(
              completedBooks:
                  7, // these values are hardcoded for now, but they will be dynamic in the future
              totalBooks: 10,
              quote: 'A reader lives a thousand lives',
            ),
            UpcomingReminderSection(),
            YourLibrarySection(),
            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }
}
