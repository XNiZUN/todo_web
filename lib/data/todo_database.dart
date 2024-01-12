import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TodoDataBase {
  List todoList = [];
  List todayList = [];
  List weekList = [];
  List sideMenu = [
    [Icons.adjust, "Today"],
    [Icons.next_week_outlined, "Week"],
    [Icons.calendar_month, "All"],
  ];

  final _myBox = Hive.box('myBox');

  void createInitialData() {
    todoList = [
      ['walk for 30 minutes', false, "week"],
      ['run at 4:00 am', false, "today"],
      ['do exercise', false, "week"],
      ['have a breakfast', false, "week"],
      ['Play PS5', false, "today"],
      ['sleep', false, "week"],
    ];
  }

  void completedSort(int index) {
    final switchElement = todoList[index];
    int i = index - 1;

    todoList.removeAt(index);

    while (i >= 0) {
      if (todoList[i][1] == false) {
        todoList.insert(i + 1, switchElement);
        break;
      } else if (i == 0) {
        todoList.insert(0, switchElement);
      }
      i--;
    }
    updateData();
  }

  void loadData() {
    todoList = _myBox.get("TODOLIST");
  }

  void updateData() {
    _myBox.put("TODOLIST", todoList);
  }
}
