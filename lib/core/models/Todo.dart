import 'dart:math';

import 'package:glory_todo_desktop/Pages/TodosPage.dart';

class Todo {
  int todoId;
  String todo;
  bool isCheck;
  var rand = new Random();
  Todo(this.todoId, this.todo, this.isCheck) {}

  factory Todo.fromJson(dynamic json) {
    //print("Tip : " + json['tabloKolonlari'].toString());
    return Todo(json['todoId'], json['todo'], json['isCheck']);
  }

  Map<String, dynamic> toJson() =>
      {'todoId': todoId, 'todo': todo, 'isCheck': isCheck};
}
