import 'package:flutter/material.dart';
import 'package:todo_application/screens/todo_details.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:todo_application/utils/database_helper.dart';
import 'package:todo_application/models/todo.dart';

// import 'package:todo_application/utils/database_helper.dart';
class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<Todo>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              debugPrint("add task button tapped");
              navigateToDetail('Add Todo');
            },
          ),
        ],
      ),
      body: getTodoListView(),
    );
  }

  ListView getTodoListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subtitle1;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  getPriorityColor(this.todoList[position].priority),
              child: getPriorityIcon(this.todoList[position].priority),
            ),
            title: Text(
              this.todoList[position].title,
              style: titleStyle,
            ),
            subtitle: Text(this.todoList[position].date),
            trailing: GestureDetector(
              child: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                _delete(context, todoList[position]);
              },
            ),
            onTap: () {
              debugPrint("Listfile deleted");
              navigateToDetail('Edit Todo');
            },
          ),
        );
      },
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Todo todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showSnackBar(context, 'Todo Deleted Successfully');
      // updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(title);
    }));
  }
}
