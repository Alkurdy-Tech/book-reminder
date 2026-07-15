import 'package:flutter/material.dart';

class Fbook extends StatefulWidget {
  const Fbook({super.key});

  @override
  State<Fbook> createState() => _NextbookState();
}

class _NextbookState extends State<Fbook> {
  int rating = 0;
  int rating1 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(11),
              color: const Color.fromARGB(255, 236, 236, 236),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ---------- BOOK COVER (left side) ----------
                Container(
                  width: 50,
                  height: 75,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B3A4B), // dark blue color
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.orange, width: 1.5),
                  ),
                ),

                const SizedBox(width: 16), // space between cover and text

                // ---------- TEXT + PROGRESS BAR (right side) ----------
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Book Title
                    Text(
                      "bookTitle",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Author Name
                    Text(
                      "authorName",
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),

                    const SizedBox(height: 8),

                    // Category badge + page count
                    Row(
                      children: [
                        // Category chip (the rounded "Fiction" label)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "category",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.orange[800],
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // Page count text
                        Text(
                          "{totalPages}pp",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // ---------- PROGRESS BAR ----------
                    Row(
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              rating1 = index + 1;
                            });
                          },
                          child: Icon(
                            index < rating1 ? Icons.star : Icons.star_border,
                            color: Colors.deepOrange,
                            size: 22,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 6),

                    // Pages read text (e.g. "187 / 304 · 62%")
                    Text(
                      "pagesRead totalPages percentage",
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
