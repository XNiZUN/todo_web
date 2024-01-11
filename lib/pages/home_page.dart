import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_web/data/todo_database.dart';
import '../util/dialog_box.dart';
import '../util/todo_tile.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myBox = Hive.box('mybox');

  TodoDataBase db = TodoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final _controller = TextEditingController();

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.completedSort();

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
      db.todoList.add([_controller.text, false]);
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
      backgroundColor: Color(0xFF161A30),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
      appBar: width <= 700
          ? AppBar(
              backgroundColor: Color.fromARGB(255, 1, 22, 56),
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
      drawer: (width <= 700
          ? Drawer(
              child: Container(
                color: Color.fromARGB(255, 0, 0, 0),
                child: ListView.builder(
                  itemCount: db.sideMenu.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Text(db.sideMenu[index][1]),
                    );
                  },
                ),
              ),
            )
          : null),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              (width > 700 ? desktopView() : mobileView()),
              Center(
                widthFactor: 1,
                child: SizedBox(
                  width: 500,
                  child: ListView.builder(
                    itemCount: db.todoList.length,
                    itemBuilder: (context, index) {
                      return TodoTile(
                        taskName: db.todoList[index][0],
                        taskCompleted: db.todoList[index][1],
                        onChanged: ((value) => checkBoxChanged(value, index)),
                        deleteFunction: (context) => deleteTask(index),
                      );
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
    return Row(
      children: [
        Container(
          width: 200,
          child: ListView.builder(
            itemCount: db.sideMenu.length,
            itemBuilder: (context, index) {
              return Row(children: [
                Icon(
                  db.sideMenu[index][0],
                  color: Colors.white,
                ),
                Text(db.sideMenu[index][1]),
              ]);
            },
          ),
        ),
        const SizedBox(
          width: 100,
        ),
      ],
    );
  }

  Widget mobileView() {
    return Row();
  }
}
