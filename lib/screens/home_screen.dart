import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Mastery League'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Habit Mastery League 🚀',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}