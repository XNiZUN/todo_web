import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {
  List todoList = [];
  List sideMenu = [
    [Icons.adjust, "Today"],
    [Icons.next_week_outlined, "Week"],
    [Icons.calendar_month, "All"],
  ];

  final _myBox = Hive.box('myBox');

  void createInitialData() {
    todoList = [
      ['datesortdate sort date sort date sort date sort date sort ', false],
      ['urgent sort', false],
      ['grid template', false],
      ['day plan', false],
      ['week plan', false],
      ['all', false],
    ];
  }

  void daySort() {}

  void weekSort() {}

  void completedSort() {
    for (int i = 0; i < todoList.length; i++) {
      if (todoList[i][1] == true) {
        todoList.add(todoList[i]);
        todoList.removeAt(i);
      }
    }
  }

  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  void updateData() {
    _myBox.put("TODOLIST", todoList);
  }
}
