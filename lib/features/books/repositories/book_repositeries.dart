import 'package:book_reminder/core/database/app_database.dart';
import 'package:book_reminder/features/books/models/book_model.dart';

class BookRepositeries {
  Future<void> insertBook(BookModel book) async {
    final db = await AppDatabase.database;

    await db.insert(
      'books',
      book.toMap(),
    ); // this is semplified because i used toMap and fromMap in bookModel.dart page
  }

  Future<List<BookModel>> getBooks() async {
    final db = await AppDatabase.database;

    final List<Map<String, dynamic>> maps = await db.query('books');

    return maps.map((map) => BookModel.fromMap(map)).toList();
  }
}
