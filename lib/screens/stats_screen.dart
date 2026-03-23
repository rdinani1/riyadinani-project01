import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  int totalHabits = 0;
  int completedHabits = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final habits = await DatabaseHelper.instance.getHabits();

    setState(() {
      totalHabits = habits.length;
      completedHabits = habits.where((habit) => habit.isCompleted).length;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final incompleteHabits = totalHabits - completedHabits;
    final completionRate = totalHabits == 0
        ? 0.0
        : (completedHabits / totalHabits) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Stats'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Progress',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: ListTile(
                      title: const Text('Total Habits'),
                      trailing: Text(
                        totalHabits.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      title: const Text('Completed Habits'),
                      trailing: Text(
                        completedHabits.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      title: const Text('Incomplete Habits'),
                      trailing: Text(
                        incompleteHabits.toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      title: const Text('Completion Rate'),
                      trailing: Text(
                        '${completionRate.toStringAsFixed(1)}%',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}