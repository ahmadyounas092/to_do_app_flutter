import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_application/data/database.dart';
import 'package:to_do_application/utils/dialogue_box.dart';
import 'package:to_do_application/utils/todo_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();

  final mybox = Hive.box("MyBox");

  TodoDatabase tdb = TodoDatabase();
  @override
  void initState() {
    super.initState();
    // if this is first time opening the app
    if(mybox.get('TODOLIST') == null){
      tdb.createInitialData();
    } else{
      // the data already exists
      tdb.loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("To Do App"),
        titleTextStyle: TextStyle(
            color: Colors.white, fontSize: 26, fontWeight: FontWeight.w500),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: addNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: tdb.todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
              taskName: tdb.todoList[index][0],
              taskCompleted: tdb.todoList[index][1],
              onChanged: (value)=> checkBoxChanged(value, index),
            deleteTask: (context)=> deleteTask(index),
          );
        },
      ),
    );
  }
  void checkBoxChanged(bool? value, int index){
    setState(() {
      tdb.todoList[index][1] = !tdb.todoList[index][1];
      tdb.updateDatabase();
    });
  }
  void addNewTask(){
    showDialog(
        context: context,
        builder: (context){
          return DialogueBox(
            inputController: controller,
            onSave: saveNewTask,
            onCancel: ()=> Navigator.pop(context),
          );
        }
    );
  }
  void saveNewTask(){
    setState(() {
      tdb.todoList.add([controller.text, false]);
      controller.clear();
      tdb.updateDatabase();
    });
    Navigator.of(context).pop();
  }
  void deleteTask(int index){
    setState(() {
      tdb.todoList.removeAt(index);
      tdb.updateDatabase();
    });
  }
}
