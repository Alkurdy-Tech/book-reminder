import 'package:book_reminder/features/books/controllers/book_controllers.dart';
import 'package:book_reminder/features/books/widgets/book_form.dart';
import 'package:flutter/material.dart';

class AddBookPage extends StatelessWidget {
  const AddBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = BookController();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Book')),
      body: BookForm(
        onSave: (book) {
          controller.addBook(book);
          Navigator.pop(context);
        },
      ),
    );
  }
}
