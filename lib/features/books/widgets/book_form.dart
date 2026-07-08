import 'package:flutter/material.dart';

class BookForm extends StatelessWidget {
  const BookForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(decoration: InputDecoration(labelText: 'Title')),

        TextField(decoration: InputDecoration(labelText: 'Author')),

        TextField(decoration: InputDecoration(labelText: 'Total Pages')),

        ElevatedButton(onPressed: () {}, child: Text('Save Book')),
      ],
    );
  }
}
