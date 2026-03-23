import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/habit.dart';
import 'add_habit_screen.dart';

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

  Future<void> _editHabit() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddHabitScreen(habit: _habit),
      ),
    );

    if (result == true && _habit.id != null) {
      final habits = await DatabaseHelper.instance.getHabits();
      final refreshedHabit = habits.firstWhere((habit) => habit.id == _habit.id);

      setState(() {
        _habit = refreshedHabit;
      });
    }
  }

  Future<void> _deleteHabit() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Habit'),
          content: const Text(
            'Are you sure you want to delete this habit?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true && _habit.id != null) {
      await DatabaseHelper.instance.deleteHabit(_habit.id!);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Habit deleted successfully!'),
        ),
      );

      Navigator.pop(context, true);
    }
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
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _editHabit,
                  child: const Text('Edit Habit'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _deleteHabit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Delete Habit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}