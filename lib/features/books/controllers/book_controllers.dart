import 'package:book_reminder/features/books/models/book_model.dart';
import 'package:book_reminder/features/books/repositories/book_repositeries.dart';

class BookController {
  final BookRepositeries repositeries;

  BookController({required this.repositeries});

  Future<void> addBook(BookModel book) async {
    await repositeries.insertBook(book);
  }

  Future<List<BookModel>> getBooks() async {
    return await repositeries.getBooks();
  }
}
