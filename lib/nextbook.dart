import 'package:flutter/material.dart';

class Nextbook extends StatelessWidget {
  const Nextbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Text("My Book"),
          actions: [
            ElevatedButton(onPressed: () {}, child: const Icon(Icons.add)),
          ],
          backgroundColor: const Color.fromARGB(255, 136, 83, 64),
        ),

        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           
            Expanded(
              flex: 2,
              child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
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
          Expanded(
            child: Column(
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
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: 0.3, // 0.0 to 1.0
                    minHeight: 6,
                    backgroundColor: Colors.grey[300],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.deepOrange,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                // Pages read text (e.g. "187 / 304 · 62%")
                Text(
                  "pagesRead totalPages percentage",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
              ),
            )
          ],
        ),
        bottomSheet: Container(
          child: Container(
                 width: MediaQuery.of(context).size.width,
                color:Colors.brown,
                margin: EdgeInsets.all(0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                    ElevatedButton(
                      onPressed: () {Navigator.pushNamed(context, '/Screen');},
                      child: Icon(Icons.read_more, size: 44),
                     style: ButtonStyle( backgroundColor: WidgetStateProperty.all(Colors.brown)),),
                     SizedBox(width: 45,),
                    ElevatedButton(
                      onPressed: () {Navigator.pushNamed(context, '/Nextbook');},
                      child: Icon(Icons.book, size: 44),
                    ),
                    SizedBox(width: 45,),
                    ElevatedButton(
                      onPressed: () {Navigator.pushNamed(context, '/Fbook');},
                      child: Icon(Icons.done_all, size: 44),
                    ),
                  ],
                ),
              ),
        )
        );

  }
}