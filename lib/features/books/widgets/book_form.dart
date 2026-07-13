import 'package:book_reminder/features/books/models/book_model.dart';
import 'package:flutter/material.dart';

class BookForm extends StatefulWidget {
  final Function(BookModel) onSave;

  const BookForm({super.key, required this.onSave});

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {

  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController pagesController = TextEditingController();


  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    pagesController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: 'Title')),
        TextField(
          controller: authorController,
          decoration: const InputDecoration(labelText: 'Author')),
        TextField(
          controller: pagesController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Total Pages')),

        ElevatedButton(
          onPressed: () {
            final book = BookModel(
              title: titleController.text,
              author: authorController.text,
              totalPages: int.parse(pagesController.text),
            );

            widget.onSave(book);
          },
          child: Text('Save Book'),
        ),
      ],
    );
  }
}
