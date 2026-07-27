
import 'dart:io';

import 'package:book_reminder/database/book_model.dart';
import 'package:flutter/material.dart';

Widget buildBookCard(Book book) {
  return Container(
    margin: EdgeInsets.all(6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(11),
      color: const Color.fromARGB(255, 236, 236, 236),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- BOOK COVER (left side) ----------
       Container(
              width: 50,
              height: 75,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.orange, width: 1.5),
              color: const Color(0xFF1B3A4B), // fallback color if no image
              ),
                child: book.coverPath.isNotEmpty
            ? ClipRRect(
              borderRadius: BorderRadius.circular(5),
             child: Image.file(
             File(book.coverPath),
            fit: BoxFit.cover,
          ),
        )
      : null, // shows just the colored box if no cover was set
   ),

        const SizedBox(width: 16),

        // ---------- TEXT + PROGRESS BAR (right side) ----------
        Expanded( // <-- added: prevents overflow, since Row no longer has fixed width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book Title (was "bookTitle")
              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 4),

              // Author Name (was "authorName")
              Text(
                book.author,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  // Category chip (was "category")
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      book.genre,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),
                ],
              ),

              const SizedBox(height: 10),

              // ---------- PROGRESS BAR ----------
              ClipRRect( // <-- removed fixed-width SizedBox(350), let it fill the Expanded space
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: book.progress, // was hardcoded 0.5
                  minHeight: 6,
                  backgroundColor: Colors.grey[300],
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Colors.deepOrange,
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // Progress percentage text
              Text(
                "${(book.progress * 100).toStringAsFixed(0)}% complete",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
