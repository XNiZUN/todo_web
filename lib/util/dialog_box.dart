// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:todo_web/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: const Color(0xFF303030),
        content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Add new task",
                      hintStyle:
                          TextStyle(color: Color.fromARGB(115, 255, 255, 255)),
                    )),
                Row(children: [
                  MyButton(text: "Save", onPressed: onSave),
                  const SizedBox(
                    width: 4,
                  ),
                  MyButton(text: "Cancel", onPressed: onCancel)
                ])
              ],
            )));
  }
}
