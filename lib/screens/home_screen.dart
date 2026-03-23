import 'package:flutter/material.dart';
import 'add_habit_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Mastery League'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Add Your First Habit'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddHabitScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}