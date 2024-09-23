import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final void Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;

  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18.0, top: 15.0, bottom: 0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              // Make the delete button rounded and smaller
              spacing: 0, // Removes extra spacing around icon
              autoClose: true, // Ensures automatic closure after action
              label: 'Delete',
              padding: const EdgeInsets.all(0), // Minimize padding to reduce button size
              borderRadius: BorderRadius.circular(12.5), // Rounded corners for delete button
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20), // Reduce padding for a more compact tile
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.deepPurple[100],
          ),
          child: Row(
            children: [
              // Checkbox for the task (completed or not)
              Checkbox(
                value: taskCompleted,
                onChanged: onChanged,
                checkColor: Colors.black,
              ),
              // Task name
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                  ),
                  overflow: TextOverflow.ellipsis, // If the text is too long, it shows ellipsis
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
