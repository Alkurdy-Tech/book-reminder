import 'package:flutter/material.dart';

class ReadingProgressCard extends StatelessWidget {
  final int completedBooks;
  final int totalBooks;
  final String quote;

  const ReadingProgressCard({
    super.key,
    required this.completedBooks,
    required this.totalBooks,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalBooks > 0 ? completedBooks / totalBooks : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.menu_book),
                  SizedBox(width: 8.0),
                  Text(
                    'Reading Progress',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Text(
                '$completedBooks of $totalBooks books completed',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 8.0),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 8.0),
              Text('${(progress * 100).toStringAsFixed(0)}% completed'),
              const SizedBox(height: 8.0),
              Text(
                'motivation quote here',
              ), // Motivation quetes should be add by users when they see it in their books and they can add it to the motivation table which will show it for the users.
            ],
          ),
        ),
      ),
    );
  }
}
