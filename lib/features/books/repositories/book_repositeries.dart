import 'package:book_reminder/core/database/app_database.dart';
import 'package:book_reminder/features/books/models/book_model.dart';

class BookRepositeries {
  Future<void> insertBook(BookModel book) async {
    final db = await AppDatabase.database;

    await db.insert('books', {
      'title': book.title,
      'author': book.author,
      'totalPages': book.totalPages,
      'currentPage': book.currentPage,
      'isFinished': book.isFinished ? 1 : 0,
    });
  }
}
