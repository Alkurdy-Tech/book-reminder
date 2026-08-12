
import 'package:flutter/material.dart';
import 'database/app_database.dart';
import 'database/book_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Addbook extends StatefulWidget {
   Addbook({super.key});

  @override
  State<Addbook> createState() => _AddbookState();
}

class _AddbookState extends State<Addbook> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController authorController = TextEditingController();

  final TextEditingController pageController = TextEditingController();

  final TextEditingController genreController = TextEditingController();

    File? selectedImage; // holds the picked image file

    Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
    }
  }
  // saveBook now takes context as a parameter, since StatelessWidget has none
  Future<void> _saveBook(BuildContext context) async {
    final newBook = Book(
    title: titleController.text,
    author: authorController.text,
    genre: genreController.text,
    coverPath: selectedImage?.path ?? "",
    totalPages: int.tryParse(pageController.text) ?? 0,  // from your page TextField
    pagesRead: 0,  // starts
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
                  GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SafeArea(
                      child: Wrap(
                        children: [
                          ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text("Photo Library"),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.gallery);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text("Camera"),
                            onTap: () {
                              Navigator.pop(context);
                              _pickImage(ImageSource.camera);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFE7DA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.brown[200]!, style: BorderStyle.solid),
                ),
                child: selectedImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_outlined, color: Colors.brown[300]),
                              const SizedBox(width: 6),
                              Icon(Icons.camera_alt_outlined, color: Colors.brown[300]),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Photo Library or Camera",
                            style: TextStyle(color: Colors.brown[300], fontSize: 13),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(selectedImage!, fit: BoxFit.cover, width: double.infinity, height: 120),
                      ),
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
                 style: TextStyle(color: Colors.black87),
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
                style: TextStyle(color: Colors.black87),
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
                          style: TextStyle(color: Colors.black87),  
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
                          style: TextStyle(color: Colors.black87),  
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
  
}