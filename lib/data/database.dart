import 'package:hive_flutter/adapters.dart';

class TodoDatabase {
  List todoList = [];
  // reference our box
  final mybox = Hive.box("MyBox");

  void createInitialData(){
    todoList = [
      ['Make Tutorial', false],
      ['Do Exercise', false],
    ];
  }

  void loadData() {
    todoList = mybox.get("TODOLIST");
  }
  void updateDatabase() async{
    await mybox.put("TODOLIST", todoList);
  }
}