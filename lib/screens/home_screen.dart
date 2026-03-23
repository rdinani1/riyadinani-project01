import 'package:flutter/material.dart';
import 'habit_list_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Mastery League'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
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
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              child: const Text('View Stats'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StatsScreen(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}