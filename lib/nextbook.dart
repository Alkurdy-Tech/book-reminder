import 'package:flutter/material.dart';

class Nextbook extends StatelessWidget {
  const Nextbook({super.key});

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
              color: const Color.fromARGB(255, 236, 236, 236)),
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
                  ElevatedButton(onPressed: (){},
                   child: Text('start reading ' ,style: TextStyle(color: Colors.white),),
                   style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.deepOrange)),
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
                         
                 ],
                     ),
             ),
              
            
          ],
        ),
        );

  }
}