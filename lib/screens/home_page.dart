import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo/data/database.dart';
import 'package:todo/widgets/dialog_box.dart';
import 'package:todo/widgets/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// reference the hive box
var _myBox = Hive.box('mybox');
TodoDatabase db = TodoDatabase();

// text controller
final _textController = TextEditingController();

class _HomePageState extends State<HomePage> {
  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  // add new task
  void _addNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DiaLogBox(
          onSave: _saveNewTask,
          controller: _textController,
        );
      },
    );
  }

  // save new task
  void _saveNewTask() {
    setState(() {
      if (_textController.text.isNotEmpty) {
        db.todoList.add([_textController.text, false]);
      }
    });
    _textController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  // initstate hive
  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      db.createInitData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  // dispose textcontroller
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        elevation: 0,
        title: const Text('Todo List'),
        actions: [
          IconButton(onPressed: _addNewTask, icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: db.todoList.length,
            itemBuilder: (context, index) {
              return Dismissible(
                onResize: () {},
                background: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.only(right: 30),
                    alignment: Alignment.centerRight,
                    color: Colors.red.shade300,
                    child: Icon(
                      Icons.delete,
                      size: 30.h,
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  deleteTask(index);
                },
                confirmDismiss: (direction) async {
                  final bool confirm = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirm'),
                        content: const Text(
                            'Are you sure you want to delete this item?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('Cancle'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            child: const Text('Delete'),
                          ),
                        ],
                      );
                    },
                  );
                  return confirm;
                },
                key: ValueKey(db.todoList[index]),
                child: TodoTile(
                  onChanged: (value) {
                    checkBoxChanged(value, index);
                  },
                  text: db.todoList[index][0],
                  isCompeleted: db.todoList[index][1],
                ),
              );
            },
          )),
    );
  }
}
