import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:intl/intl.dart';
import '../services/firestore.dart';

class TaskItem extends StatefulWidget {
  final Task task;

  const TaskItem(this.task, {super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value)  {
                    setState(()  {
                      isChecked = value!;
                      // Update the isChecked value in the Task object.
                      widget.task.isChecked = value;

                      // Save the Task object to the database.
                      FirestoreService().updateTask(widget.task);

                    });
                  },
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.task.title,
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text(widget.task.description),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Date: ${DateFormat('dd/MM/yyyy HH:mm').format(widget.task.date)}',
                          textAlign: TextAlign.left),
                      SizedBox(height: 5),
                      Text('Category:${widget.task.category.name}',
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    FirestoreService().deleteTaskByTitle(widget.task.title);
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
