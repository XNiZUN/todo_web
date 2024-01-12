// ignore_for_file: must_be_immutable, unused_element, camel_case_types

import 'package:flutter/material.dart';
import 'package:todo_web/data/todo_database.dart';

class drawer extends StatelessWidget {
  Function(int) activePageBack;

  drawer({super.key, required this.activePageBack});

  TodoDataBase db = TodoDataBase();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: ListView.builder(
        itemCount: db.sideMenu.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                activePageBack(index);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(0, 25, 28, 31),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      db.sideMenu[index][0],
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(db.sideMenu[index][1]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
