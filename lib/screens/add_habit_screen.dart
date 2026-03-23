import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/habit.dart';

class AddHabitScreen extends StatefulWidget {
  final Habit? habit;

  const AddHabitScreen({super.key, this.habit});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = 'Study';

  final List<String> _categories = [
    'Study',
    'Health',
    'Fitness',
    'Personal',
  ];

  bool get _isEditing => widget.habit != null;

  @override
  void initState() {
    super.initState();

    if (widget.habit != null) {
      _titleController.text = widget.habit!.title;
      _descriptionController.text = widget.habit!.description;
      _selectedCategory = widget.habit!.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _saveHabit() async {
    if (_formKey.currentState!.validate()) {
      if (_isEditing) {
        final updatedHabit = Habit(
          id: widget.habit!.id,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          category: _selectedCategory,
          createdAt: widget.habit!.createdAt,
          isCompleted: widget.habit!.isCompleted,
        );

        await DatabaseHelper.instance.updateHabit(updatedHabit);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Habit updated successfully!'),
          ),
        );
      } else {
        final newHabit = Habit(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          category: _selectedCategory,
          createdAt: DateTime.now().toIso8601String(),
          isCompleted: false,
        );

        await DatabaseHelper.instance.insertHabit(newHabit);

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Habit saved successfully!'),
          ),
        );
      }

      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Habit' : 'Add New Habit'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                _isEditing
                    ? 'Update your habit details below.'
                    : 'Create a new habit to start building consistency.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Habit Title',
                  hintText: 'Enter habit title',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.edit_note),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a habit title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter habit description',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 18),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveHabit,
                  icon: Icon(_isEditing ? Icons.save : Icons.add),
                  label: Text(_isEditing ? 'Update Habit' : 'Save Habit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}