import 'package:flutter/material.dart';

class ReminderCard extends StatelessWidget {
  const ReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(Icons.menu_book),
        title: Text('Atomic Habits'),
        subtitle: Text('Today * 8:00 PM'),
        trailing: Icon(Icons.notifications_active),
      ),
    );
  }
}
