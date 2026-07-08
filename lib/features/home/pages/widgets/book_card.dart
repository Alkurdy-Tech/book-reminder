import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final int currentPage;
  final int totalPages;

  // final String? coverImage;
  // final bool isFinished;
  // final DateTime? lastReadAt;
  // final double? rating;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalPages == 0 ? 0.0 : currentPage / totalPages;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(Icons.menu_book_rounded, size: 40),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleMedium),

                    const SizedBox(height: 4),

                    Text(author, style: Theme.of(context).textTheme.bodyMedium),

                    const SizedBox(height: 12),

                    LinearProgressIndicator(value: progress),

                    const SizedBox(height: 6),

                    Text(
                      '$currentPage / $totalPages pages',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
