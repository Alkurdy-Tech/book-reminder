import 'package:flutter/material.dart';
import 'database/app_database.dart';
import 'database/book_model.dart';

class Addbook extends StatelessWidget {
  Addbook({super.key});

  // Renamed to match what _saveBook expects, and added a coverPath controller
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController pageController = TextEditingController();
  final TextEditingController genreController = TextEditingController();

  // saveBook now takes context as a parameter, since StatelessWidget has none
  Future<void> _saveBook(BuildContext context) async {
    final newBook = Book(
      title: titleController.text,
      author: authorController.text,
      genre: genreController.text,
      coverPath: "", // placeholder for now — see note below
      progress: 0.0, // starts unread
    );

    await AppDatabase.instance.insertBook(newBook);
    Navigator.pop(context); // go back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... your existing UI, e.g. TextFields using titleController, authorController, etc.
      body: Column(
        children: [
          TextField(controller: titleController, decoration: InputDecoration(labelText: "Title")),
          TextField(controller: authorController, decoration: InputDecoration(labelText: "Author")),
          TextField(controller: genreController, decoration: InputDecoration(labelText: "Genre")),
          TextField(controller: pageController, decoration: InputDecoration(labelText: "Pages")),
          ElevatedButton(
            onPressed: () {
              _saveBook(context); // pass context in from build()
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}