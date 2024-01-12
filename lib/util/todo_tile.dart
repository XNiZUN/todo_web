// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final String taskDay;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  TodoTile({
    super.key,
    required this.taskName,
    required this.taskDay,
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
                color: const Color(0xFF242726),
                borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: Colors.black,
                ),
                SizedBox(
                    width: 394,
                    height: 20,
                    child: OverflowBox(
                      maxWidth: 394,
                      maxHeight: 20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            taskName,
                            style: TextStyle(
                                decoration: taskCompleted
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none),
                          ),
                          Row(
                            children: [
                              Text(
                                taskDay,
                                style: TextStyle(
                                  color: taskDay == "week"
                                      ? const Color.fromARGB(255, 26, 255, 0)
                                      : const Color.fromARGB(255, 255, 145, 0),
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
