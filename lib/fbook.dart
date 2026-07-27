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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Finished Books")),
      body: finishedBooks.isEmpty
          ? Center(child: Text("No finished books yet"))
          : ListView.builder(
              itemCount: finishedBooks.length,
              itemBuilder: (context, index) {
                return buildBookCard(finishedBooks[index]);
              },
            ),
    );
  }
}