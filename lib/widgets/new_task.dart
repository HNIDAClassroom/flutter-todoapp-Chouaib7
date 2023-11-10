import 'package:flutter/material.dart';
import '../models/task.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key, required this.onAddTask});

  final void Function(Task task) onAddTask;

  @override
  State<NewTask> createState() {
    return _NewTaskState();
  }
}

class _NewTaskState extends State<NewTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  Category _selectedCategory = Category.personal;
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Initialize the date controller with the current date.
    _dateController.text = DateTime.now().toString();
  }

  void _submitTaskData() {
    if ((_titleController.text.trim().isEmpty) ||
        (_descriptionController.text.trim().isEmpty)) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text(
              'Merci de saisir le titre de la tâche à ajouter dans la liste'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddTask(Task(
        title: _titleController.text,
        description: _descriptionController.text,
        date: DateTime.parse(_dateController.text),
        category: _selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Task title',
            ),
          ),
          TextField(
            controller: _descriptionController,
            maxLength: 50,
            decoration: InputDecoration(
              labelText: 'Task description',
            ),
          ),
          TextField(
            controller: _dateController,
            onTap: () async {
              // Open the date picker.
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2023),
                lastDate: DateTime(2030),
              );

              // If the user selected a date, update the text field.
              if (pickedDate != null) {
                setState(() {
                  _dateController.text = pickedDate.toString();
                });
              }
            },
          ),
          Row(
            children: [
              DropdownButton<Category>(
                value: _selectedCategory,
                style: TextStyle(color: Color.fromARGB(255, 12, 12, 12)),
                items: Category.values
                    .map((category) => DropdownMenuItem<Category>(
                          value: category,
                          child: Text(
                            category.name
                                .toUpperCase(), 
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }

                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _submitTaskData();
                  print(_titleController.text);
                },
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
