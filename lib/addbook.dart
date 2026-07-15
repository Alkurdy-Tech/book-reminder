
import 'package:flutter/material.dart';
import 'database/app_database.dart';
import 'database/book_model.dart';


class Addbook extends StatelessWidget {
   Addbook({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController pageController = TextEditingController();
  final TextEditingController genreController = TextEditingController();

  // saveBook now takes context as a parameter, since StatelessWidget has none
  Future<void> _saveBook(BuildContext context) async {
    final newBook = Book(
      title: titleController.text,
      author: authorController.text,
      genre: genreController.text,
      coverPath: "", // placeholder for now — see note below
      progress: 0.0, // starts unread
    );

    await AppDatabase.instance.insertBook(newBook);
    Navigator.pop(context); // go back after saving
  }
  Widget build(BuildContext context) {
    return Dialog(
          
      backgroundColor: const Color(0xFFF5F1EA), // light cream background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          // lets the dialog scroll if content is too tall
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- TITLE ROW ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Add a Book",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  // Close (X) button
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context); // closes the dialog
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // ---------- BOOK COVER LABEL ----------
              const Text(
                "BOOK COVER",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                  letterSpacing: 1.0,
                ),
              ),

              const SizedBox(height: 8),

              // ---------- PHOTO UPLOAD BOX ----------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE6DA),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.image_outlined, size: 24, color: Colors.grey),
                    const SizedBox(height: 6),
                    Text(
                      "Photo Library or Camera",
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ---------- TITLE FIELD ----------
              const Text(
                "TITLE *",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: titleController,
                decoration: _fieldStyle("Book title"),
              ),

              const SizedBox(height: 16),

              // ---------- AUTHOR FIELD ----------
              const Text(
                "AUTHOR *",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: authorController,
                decoration: _fieldStyle("Author name"),
              ),

              const SizedBox(height: 16),

              // ---------- PAGES + GENRE ROW ----------
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "PAGES *",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          keyboardType: TextInputType.number,
                          decoration: _fieldStyle("320"),
                          controller: pageController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "GENRE",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown,
                          ),
                        ),
                        const SizedBox(height: 6),
                        TextField(
                          controller: genreController,
                          decoration: _fieldStyle("Fiction"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // ---------- ADD TO LABEL ----------
              const Text(
                "ADD TO",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),

              const SizedBox(height: 8),

              // ---------- ADD TO CHIPS (Reading / Up Next / Finished) ----------
              Row(
                children: [
                  Expanded(child: _statusChip("Reading", selected: false)),
                  const SizedBox(width: 8),
                  Expanded(child: _statusChip("Up Next", selected: true)),
                  const SizedBox(width: 8),
                  Expanded(child: _statusChip("Finished", selected: false)),
                ],
              ),

              const SizedBox(height: 20),

              // ---------- CANCEL + ADD BOOK BUTTONS ----------
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context); // closes dialog
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: BorderSide(color: Colors.grey[400]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
         
                    child: ElevatedButton(
                      onPressed: () {
                        _saveBook(context);
                        // TODO: add your "save book" logic here
                        
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Add Book",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Helper: reusable text field style ----------
  InputDecoration _fieldStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFEDE6DA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
    );
  }

  // ---------- Helper: reusable "Reading/Up Next/Finished" chip ----------
  Widget _statusChip(String label, {required bool selected}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? Colors.deepOrange : const Color(0xFFEDE6DA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}