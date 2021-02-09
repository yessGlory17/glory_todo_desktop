import 'package:glory_todo_desktop/core/models/Project.dart';
import 'dart:math';
import 'package:glory_todo_desktop/core/models/Todo.dart';

class ProjectColumn {
  int columnId;
  String columnName;
  List<dynamic> todos;

  ProjectColumn(this.columnId, this.columnName,
      this.todos) {} //Kategori eklerken kullan çünkü id dbden veriliyor

  //Kategorileri dbden okurken kullanılır.
  ProjectColumn.withID(this.columnId, this.columnName, this.todos) {
    //punicColumnId = rand.nextInt(1000000 - 10000).toString();
  }
  ProjectColumn.addColumnContructor(this.columnId, this.columnName) {
    todos = [];
  }

  factory ProjectColumn.fromJson(dynamic json) {
    return ProjectColumn(json['columnId'], json['columnName'],
        json['todos'] /*Burada Casting vardı .cast<Todo>() */);
  }

  Map<String, dynamic> toJson() =>
      {'columnId': columnId, 'columnName': columnName, 'todos': todos};
}
