import 'package:flutter/material.dart';
import 'habit_list_screen.dart';

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
          child: const Text('View My Habits'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HabitListScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}