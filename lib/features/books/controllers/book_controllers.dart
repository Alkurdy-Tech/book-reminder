import 'package:book_reminder/features/books/models/book_model.dart';

class BookController {

  void addBook(BookModel book) {
    print('Book added: ${book.title}');
  }
}