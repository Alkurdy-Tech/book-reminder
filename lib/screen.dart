import 'dart:io';

import 'package:book_reminder/addbook.dart';
import 'package:book_reminder/widget/update_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'database/app_database.dart';
import 'database/book_model.dart';
import 'widget/book_card.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => ScreenState();
}

class ScreenState extends State<Screen> {
  List<Book> books = [];
  int currentIndex = 0; // which "currently reading" book is shown

  @override
  void initState() {
    super.initState();
    loadBooks();
  }

  Future<void> loadBooks() async {
    final data = await AppDatabase.instance
        .getCurrentlyReadingBooks(); // <-- only unfinished books
    setState(() {
      books = data;
      if (currentIndex >= books.length)
        currentIndex = 0; // avoid out-of-range after finishing a book
    });
  }

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text("No books in progress — add one to get started!"),
        ),
      );
    }

    final book =
        books[currentIndex]; // <-- currently reading book, first in the list

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- SMALL LABEL AT TOP ----------
              const Text(
                "   CURRENTLY READING",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  letterSpacing: 1.2,
                ),
              ),
              if (books.length >
                  1) // only show arrows if there's more than 1 book
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.chevron_left, size: 20),
                      onPressed: () {
                        setState(() {
                          currentIndex =
                              (currentIndex - 1 + books.length) % books.length;
                        });
                      },
                    ),
                    Text(
                      "${currentIndex + 1}/${books.length}",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    IconButton(
                      icon: Icon(Icons.chevron_right, size: 20),
                      onPressed: () {
                        setState(() {
                          currentIndex = (currentIndex + 1) % books.length;
                        });
                      },
                    ),
                  ],
                ),
              const SizedBox(height: 12),

              // ---------- TOP ROW: cover + title + circle ----------
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Book cover
                  // Book cover
                  Container(
                    margin: EdgeInsets.all(3),
                    width: 60,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFF1B3A4B,
                      ), // fallback color if no image
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.orange, width: 1.5),
                    ),
                    child: book.coverPath.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.file(
                              File(book.coverPath),
                              fit: BoxFit.cover,
                              width: 80,
                              height: 120,
                            ),
                          )
                        : null, // shows just the colored box if no cover was picked
                  ),
                  const SizedBox(width: 16),

                  // Title, author, circle progress, page info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Book title
                      Text(
                        book.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Author
                      Text(
                        book.author,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.brown[400],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Row with circle % + page details
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ---------- CIRCULAR PROGRESS ----------
                          SizedBox(
                            width: 55,
                            height: 55,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // The circle track + progress
                                SizedBox(
                                  width: 55,
                                  height: 55,
                                  child: CircularProgressIndicator(
                                    value: book.progress, // 0.0 to 1.0
                                    strokeWidth: 5,
                                    backgroundColor: Colors.grey[300],
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          Colors.deepOrange,
                                        ),
                                  ),
                                ),
                                // The "62%" text in the middle
                                Text(
                                  "${(book.progress * 100).round()}%",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 14),

                          // Page info + category tag
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Page ${book.pagesRead} of ${book.totalPages}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "${book.totalPages - book.pagesRead} pages left",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                ),
                              ),
                              const SizedBox(height: 6),
                              // Category chip
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  book.genre,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

            
              

              

              // ---------- BOTTOM BUTTONS ----------
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 35,
                  child: Row(
                    children: [
                      // Update Progress button (filled orange)
                      ElevatedButton.icon(
                        onPressed: () {
                          showUpdateProgressDialog(context, book, () {
                            loadBooks(); // refresh the screen after saving
                          });
                        },
                        icon: const Icon(
                          Icons.menu_book,
                          size: 13,
                          color: Colors.white,
                        ),
                        label: const Text("Update Progress"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Reminder button (outlined)
                      OutlinedButton.icon(
                        onPressed: () {
                          // TODO: add your reminder action here
                        },
                        icon: const Icon(
                          Icons.notifications_none,
                          size: 16,
                          color: Colors.orange,
                        ),
                        label: const Text(
                          "Tonight at 9 PM",
                          style: TextStyle(color: Colors.orange),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.orange),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Mark Finished button (light grey)
                      OutlinedButton.icon(
                        onPressed: () async {
                          book.isFinished = 1;
                          await AppDatabase.instance.updateBook(book);
                          loadBooks(); // reloads currently-reading list, book disappears from here
                        },

                        // TODO: add your mark finished action here
                        icon: const Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: Colors.black54,
                        ),
                        label: const Text(
                          "Mark Finished",
                          style: TextStyle(color: Colors.black54),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.grey[300]!),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return buildBookCard(books[index]);
              },
            ),
          ),
        ],
      

      ),
   floatingActionButton: FloatingActionButton(
      onPressed: () async {                          // <-- add async
                  await showDialog(                            // <-- add await
                 context: context,
                 builder: (context) => Addbook(),
                           );
                   loadBooks();                              // <-- refresh after dialog closes
                   },
      child: const  Icon(Icons.add, color: Color.fromARGB(255, 230, 76, 0)),
    ), );
  }
}
