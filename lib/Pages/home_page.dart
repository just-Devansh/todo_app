// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/Components/dialog_box.dart';
import 'package:todo_app/Components/my_button.dart';
import 'package:todo_app/Components/todo_tile.dart';
import 'package:todo_app/Data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('myBox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    // if this is the first time ever openeing the app, thenn create default data

    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    // super.initState();
  }

  // text controller
  final _controller = TextEditingController();

  // list of todo tasks
  // List db.toDoList = [
  //   ['Make Tutorial', false],
  //   ['Do Exercise', false],
  // ];
  // Removed after setting up the Hive Database as we need empty list at the start

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDataBase();
  }

  // save new task
  void saveNewTask() {
    // add task to db.toDoList
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    // pop off the dialog box
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // S T U P I D  M E  L O L !
  // Widget createNewTask() {
  //   return TextField();
  // }

  // create a new task
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
    db.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: const Text(
          'TO DO',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        onPressed: createNewTask,
        child: Icon(
          Icons.add,
          size: 30.0,
        ),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            // responsible for CHECK & UNCHECK
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
