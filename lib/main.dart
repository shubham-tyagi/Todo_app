import 'package:flutter/material.dart';
import 'package:todo_application/screens/todo_list.dart';
// import 'package:todo_application/screens/todo_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: TodoList(),
    );
  }
}
