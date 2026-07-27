
import 'package:book_reminder/database/app_database.dart';
import 'package:book_reminder/database/book_model.dart';
import 'package:flutter/material.dart';

void showUpdateProgressDialog(BuildContext context, Book book, VoidCallback onUpdated) {
  final pageController = TextEditingController(text: book.pagesRead.toString());

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Update Progress",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(book.title, style: TextStyle(color: Colors.brown[400])),
            Text("Total: ${book.totalPages} pages", style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 12),
            Text("CURRENT PAGE", style: TextStyle(fontSize: 11, color: Colors.grey[500])),
            const SizedBox(height: 6),
            TextField(
              controller: pageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: TextStyle(color: Colors.black87)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            onPressed: () async {
              final newPagesRead = int.tryParse(pageController.text) ?? book.pagesRead;

              book.pagesRead = newPagesRead;

  // Auto-mark as finished if pages read reaches or exceeds total
             if (book.pagesRead >= book.totalPages) {
              book.pagesRead = book.totalPages; // clamp so it never shows "34 of 33"
               book.isFinished = 1;
               }
         
               await AppDatabase.instance.updateBook(book);

                 Navigator.pop(context); // close dialog
                 onUpdated();      // tell the screen to refresh
                      },
                     child: Text("Save"),
          ),
        ],
      );
    },
  );
}  // adjust path/filename 