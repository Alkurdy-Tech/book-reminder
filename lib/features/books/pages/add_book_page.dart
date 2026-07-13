import 'package:book_reminder/features/books/controllers/book_controllers.dart';
import 'package:book_reminder/features/books/repositories/book_repositeries.dart';
import 'package:book_reminder/features/books/widgets/book_form.dart';
import 'package:flutter/material.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  late final BookController controller;

  @override
  void initState() {
    super.initState();

    controller = BookController(repositeries: BookRepositeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Book')),
      body: BookForm(
        onSave: (book) async {
          await controller.addBook(book);
          if (!context.mounted) return;
          Navigator.pop(context);
        },
      ),
    );
  }
}
