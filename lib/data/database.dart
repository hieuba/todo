import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todoList = [];

  // reference the hive
  final _myBox = Hive.box('mybox');

  // run this  method if this is the 1st time ever opening app
  void createInitData() {
    todoList = [
      ['Do exercise', false],
    ];
  }

  // load database
  void loadData() {
    todoList = _myBox.get('TODOLIST');
  }

  // updata Database
  void updateDatabase() {
    _myBox.put('TODOLIST', todoList);
  }
}
