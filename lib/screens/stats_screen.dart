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

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        ),
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final incompleteHabits = totalHabits - completedHabits;
    final completionRate =
        totalHabits == 0 ? 0.0 : (completedHabits / totalHabits) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Stats'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your Progress Overview',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Track how well you are keeping up with your habits.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  _buildStatCard(
                    icon: Icons.track_changes,
                    title: 'Total Habits',
                    value: totalHabits.toString(),
                  ),
                  _buildStatCard(
                    icon: Icons.check_circle,
                    title: 'Completed Habits',
                    value: completedHabits.toString(),
                  ),
                  _buildStatCard(
                    icon: Icons.pending_actions,
                    title: 'Incomplete Habits',
                    value: incompleteHabits.toString(),
                  ),
                  _buildStatCard(
                    icon: Icons.percent,
                    title: 'Completion Rate',
                    value: '${completionRate.toStringAsFixed(1)}%',
                  ),
                ],
              ),
            ),
    );
  }
}