import 'package:book_reminder/features/home/widgets/reminder_card.dart';
import 'package:book_reminder/features/home/widgets/section_title.dart';
import 'package:flutter/material.dart';

class UpcomingReminderSection extends StatelessWidget {
  const UpcomingReminderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Upcoming Reminders'),
        const SizedBox(height: 12),

        const ReminderCard(),
        // ReminderCard(),
        // ReminderCard(),
      ],
    );
  }
}
