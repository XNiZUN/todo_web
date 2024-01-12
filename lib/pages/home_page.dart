import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_web/data/todo_database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';
import '../util/drawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myBox = Hive.box('mybox');

  TodoDataBase db = TodoDataBase();

  int activePage = 3;

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
      setState(() {
        activePage = 3;
      });
    } else {
      db.loadData();
    }
    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
      if (value == true) {
        db.todoList.add(db.todoList[index]);
        db.todoList.removeAt(index);
      } else if (index != 0) {
        db.completedSort(index);
      }
    });

    db.updateData();
  }

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false, 'today']);
      db.completedSort(db.todoList.length - 1);

      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateData();
  }

  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF444444),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      appBar: width <= 800
          ? AppBar(
              backgroundColor: const Color(0xFF363636),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    color: Colors.white,
                    icon: const Icon(
                      Icons.remove_red_eye_sharp,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
                  );
                },
              ),
            )
          : null,
      drawer: (width <= 800
          ? Drawer(
              backgroundColor: const Color(0xFF5e5e5e),
              child: drawer(
                activePageBack: (index) {
                  setState(() {
                    activePage = index;
                  });
                  db.updateData();
                },
              ),
            )
          : null),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              (width > 800 ? desktopView() : const SizedBox(height: 0)),
              Center(
                widthFactor: 1,
                child: SizedBox(
                  width: 500,
                  child: ListView.builder(
                    itemCount: db.todoList.length,
                    itemBuilder: (context, index) {
                      if (activePage == 0) {
                        if (db.todoList[index][2] == "today") {
                          return TodoTile(
                            taskName: db.todoList[index][0],
                            taskDay: db.todoList[index][2],
                            taskCompleted: db.todoList[index][1],
                            onChanged: ((value) =>
                                checkBoxChanged(value, index)),
                            deleteFunction: (context) => deleteTask(index),
                          );
                        } else {
                          return const SizedBox(
                            height: 0,
                          );
                        }
                      } else if (activePage == 1) {
                        if (db.todoList[index][2] == "week") {
                          return TodoTile(
                            taskName: db.todoList[index][0],
                            taskDay: db.todoList[index][2],
                            taskCompleted: db.todoList[index][1],
                            onChanged: ((value) =>
                                checkBoxChanged(value, index)),
                            deleteFunction: (context) => deleteTask(index),
                          );
                        } else {
                          return const SizedBox(
                            height: 0,
                          );
                        }
                      } else {
                        return TodoTile(
                          taskName: db.todoList[index][0],
                          taskDay: db.todoList[index][2],
                          taskCompleted: db.todoList[index][1],
                          onChanged: ((value) => checkBoxChanged(value, index)),
                          deleteFunction: (context) => deleteTask(index),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget desktopView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          drawer(
            activePageBack: (index) {
              setState(() {
                activePage = index;
              });
              db.updateData();
            },
          ),
          const SizedBox(
            width: 100,
          ),
        ],
      ),
    );
  }
}
