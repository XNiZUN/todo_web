// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.black,
          ),
        ]),
        child: Container(
            width: 450,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
                color: Color(0xFF31304D),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),
                Container(
                    width: 394,
                    height: 20,
                    child: OverflowBox(
                      maxWidth: 394,
                      maxHeight: 20,
                      child: Text(
                        taskName,
                        style: TextStyle(
                            decoration: taskCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
