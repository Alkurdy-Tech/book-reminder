import 'package:book_reminder/features/home/widgets/book_card.dart';
import 'package:book_reminder/features/home/widgets/section_title.dart';
import 'package:flutter/material.dart';

class YourLibrarySection extends StatelessWidget {
  const YourLibrarySection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: 'Alkurdy Library'),

        SizedBox(height: 12),

        BookCard(
          title: 'Atomic Habits',
          author: 'James Clear',
          currentPage: 120,
          totalPages: 320,
        ),

        BookCard(
          title: 'The 7 Habits of Highly Effective People',
          author: 'Stephen R. Covey',
          currentPage: 80,
          totalPages: 240,
        ),

        BookCard(
          title: 'How to Win Friends and Influence People',
          author: 'Dale Carnegie',
          currentPage: 150,
          totalPages: 280,
        ),
      ],
    );
  }
}