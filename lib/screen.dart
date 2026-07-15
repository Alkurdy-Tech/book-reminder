import 'package:flutter/material.dart';
import 'database/app_database.dart';
import 'database/book_model.dart';
import 'widget/book_card.dart';   // adjust path/filename if yours is different

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  List<Book> books = [];

@override
void initState() {
  super.initState();
  _loadBooks();
}

Future<void> _loadBooks() async {
  final data = await AppDatabase.instance.getAllBooks();
  setState(() {
    books = data;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
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

                const SizedBox(height: 12),

                // ---------- TOP ROW: cover + title + circle ----------
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book cover
                    Container(
                      margin: EdgeInsets.all(3),
                      width: 60,
                      height: 90,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1B3A4B), // dark blue
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.orange, width: 1.5),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Title, author, circle progress, page info
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Book title
                        Text(
                          'bookTitle',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Author
                        Text(
                          'authorName',
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
                                      value: 0.5, // 0.0 to 1.0
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
                                    "50%",
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
                                  "Page pagesRead of totalPages",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "pagesLeft pages left",
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
                                    'category',
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

                // ---------- HORIZONTAL PROGRESS BAR ----------
                Center(
                  child: SizedBox(
                    width: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.5,
                        minHeight: 6,
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.deepOrange,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

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
                            // TODO: add your update progress action here
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
                          onPressed: () {
                            // TODO: add your mark finished action here
                          },
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
      
    );
  }
}
