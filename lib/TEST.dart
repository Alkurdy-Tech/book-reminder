// import 'package:flutter/material.dart';

// class Addbook extends StatefulWidget {
//   const Addbook({super.key});

//   @override
//   State<Addbook> createState() => _AddbookState();
// }

// class _AddbookState extends State<Addbook> {
//   File? selectedImage;

//   final TextEditingController titleController = TextEditingController();
//   final TextEditingController authorController = TextEditingController();
//   final TextEditingController genreController = TextEditingController();
//   final TextEditingController pageController = TextEditingController();

//   Future<void> _pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source, imageQuality: 80);

//     if (pickedFile != null) {
//       setState(() {
//         selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _saveBook(BuildContext context) async {
//     final newBook = Book(
//       title: titleController.text,
//       author: authorController.text,
//       genre: genreController.text,
//       coverPath: selectedImage?.path ?? "",
//       totalPages: int.tryParse(pageController.text) ?? 0,
//       pagesRead: 0,
//     );

//     await AppDatabase.instance.insertBook(newBook);
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(   // or your dialog wrapper, matching "Add a Book" title in your screenshot
//       title: Text("Add a Book"),
//       content: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("BOOK COVER", style: TextStyle(fontSize: 12, color: Colors.brown[400])),
//             const SizedBox(height: 6),

//             // 🔻🔻🔻 THE CODE YOU PASTED GOES RIGHT HERE 🔻🔻🔻
//             GestureDetector(
//               onTap: () {
//                 showModalBottomSheet(
//                   context: context,
//                   builder: (context) {
//                     return SafeArea(
//                       child: Wrap(
//                         children: [
//                           ListTile(
//                             leading: Icon(Icons.photo_library),
//                             title: Text("Photo Library"),
//                             onTap: () {
//                               Navigator.pop(context);
//                               _pickImage(ImageSource.gallery);
//                             },
//                           ),
//                           ListTile(
//                             leading: Icon(Icons.camera_alt),
//                             title: Text("Camera"),
//                             onTap: () {
//                               Navigator.pop(context);
//                               _pickImage(ImageSource.camera);
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: Container(
//                 width: double.infinity,
//                 height: 120,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFEFE7DA),
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.brown[200]!, style: BorderStyle.solid),
//                 ),
//                 child: selectedImage == null
//                     ? Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Icon(Icons.image_outlined, color: Colors.brown[300]),
//                               const SizedBox(width: 6),
//                               Icon(Icons.camera_alt_outlined, color: Colors.brown[300]),
//                             ],
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             "Photo Library or Camera",
//                             style: TextStyle(color: Colors.brown[300], fontSize: 13),
//                           ),
//                         ],
//                       )
//                     : ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image.file(selectedImage!, fit: BoxFit.cover, width: double.infinity, height: 120),
//                       ),
//               ),
//             ),
//             // 🔺🔺🔺 END OF PASTED CODE 🔺🔺🔺

//             const SizedBox(height: 16),

//             Text("TITLE *", style: TextStyle(fontSize: 12, color: Colors.brown[400])),
//             TextField(controller: titleController, decoration: InputDecoration(hintText: "Book title")),

//             const SizedBox(height: 12),
//             Text("AUTHOR *", style: TextStyle(fontSize: 12, color: Colors.brown[400])),
//             TextField(controller: authorController, decoration: InputDecoration(hintText: "Author name")),

//             // ... your genre and page fields continue here ...
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
//         ElevatedButton(
//           onPressed: () => _saveBook(context),
//           child: Text("Save"),
//         ),
//       ],
//     );
//   }
// }