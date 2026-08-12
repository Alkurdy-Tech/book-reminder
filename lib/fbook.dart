import 'package:flutter/material.dart';
import 'database/app_database.dart';
import 'database/book_model.dart';
import 'widget/book_card.dart';

class Fbook extends StatefulWidget {
  const Fbook({super.key});

  @override
  State<Fbook> createState() => _FbookState();
}

class _FbookState extends State<Fbook> {
  List<Book> finishedBooks = [];

  @override
  void initState() {
    super.initState();
    _loadFinishedBooks();
  }

  Future<void> _loadFinishedBooks() async {
    final data = await AppDatabase.instance.getFinishedBooks();
    setState(() {
      finishedBooks = data;
    });
  }

  Future<void> _restoreBook(Book book) async {
    book.isFinished = 0;
    await AppDatabase.instance.updateBook(book);
    _loadFinishedBooks(); // refresh, book disappears from this list
  }

  Future<void> _deleteBook(Book book) async {
    await AppDatabase.instance.deleteBook(book.id!);
    _loadFinishedBooks();
  }

  void _confirmDelete(Book book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete this book?"),
        content: Text('Are you sure you want to permanently delete "${book.title}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteBook(book);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Finished Books")),
      body: finishedBooks.isEmpty
          ? Center(child: Text("No finished books yet"))
          : ListView.builder(
              itemCount: finishedBooks.length,
              itemBuilder: (context, index) {
                final book = finishedBooks[index];
                return Dismissible(
                  key: Key(book.id.toString()),
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20),
                    child: Icon(Icons.replay, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      // swiped right → restore
                      await _restoreBook(book);
                      return true;
                    } else {
                      // swiped left → confirm delete
                      _confirmDelete(book);
                      return false; // don't auto-dismiss, dialog handles it
                    }
                  },
                  child: buildBookCard(book),
                );
              },
            ),
    );
  }
}