import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/habit.dart';

class HabitDetailScreen extends StatefulWidget {
  final Habit habit;

  const HabitDetailScreen({
    super.key,
    required this.habit,
  });

  @override
  State<HabitDetailScreen> createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
  late Habit _habit;

  @override
  void initState() {
    super.initState();
    _habit = widget.habit;
  }

  Future<void> _toggleCompletion() async {
    final updatedHabit = Habit(
      id: _habit.id,
      title: _habit.title,
      description: _habit.description,
      category: _habit.category,
      createdAt: _habit.createdAt,
      isCompleted: !_habit.isCompleted,
    );

    await DatabaseHelper.instance.updateHabit(updatedHabit);

    setState(() {
      _habit = updatedHabit;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _habit.isCompleted
              ? 'Habit marked as completed!'
              : 'Habit marked as not completed.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _habit.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Category: ${_habit.category}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 12),
                Text(
                  'Description: ${_habit.description.isEmpty ? "No description added" : _habit.description}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 12),
                Text(
                  'Created At: ${_habit.createdAt}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      'Status: ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      _habit.isCompleted ? 'Completed' : 'Not Completed',
                      style: TextStyle(
                        fontSize: 18,
                        color: _habit.isCompleted ? Colors.green : Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _toggleCompletion,
                  child: Text(
                    _habit.isCompleted
                        ? 'Mark as Not Completed'
                        : 'Mark as Completed',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}