import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const HabitMasteryLeagueApp());
}

class HabitMasteryLeagueApp extends StatelessWidget {
  const HabitMasteryLeagueApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Mastery League',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const HomeScreen(),
    );
  }
}