import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/core/GloryIcons/GloryIcons.dart';
import 'package:glory_todo_desktop/core/JsonManager/JsonManager.dart';
import 'ColumnWidget.dart';

class TodoWidget extends StatefulWidget {
  bool isNight;
  String todo;
  bool isTodoCheck;

  int projectId;
  String projectName;

  int columnId;
  String columnName;

  int todoId;
  final Function() updateTodos;
  TodoWidget(
      this.todo,
      this.isTodoCheck,
      this.isNight,
      this.projectId,
      this.projectName,
      this.columnId,
      this.columnName,
      this.todoId,
      this.updateTodos);
  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    String todo = widget.todo;
    return Card(
      color: widget.isNight ? Color(0xFF18191c) : Color(0xFFf1f2f6),
      child: ListTile(
        
        leading: IconButton(
          icon: Icon(
            widget.isTodoCheck
                ? GloryIcons.check_circle
                : GloryIcons.circle_empty,
            color:
                setTodoColor(), //widget.isNight ? Colors.white60 : Colors.black87,
          ),
          onPressed: () {
            setState(() {
              widget.isTodoCheck != widget.isNight;
              print("B  A S I L D I" + widget.isTodoCheck.toString());

              updateTodo(widget.projectId, widget.projectName, widget.columnId,
                  widget.columnName, widget.todoId, widget.todo);
              widget.updateTodos();
              //Tıklanan görevi bul.

              //Görevi değiştir

              //Yerine yeni görevi ekle
            });
          },
        ),
        title: Text(
          todo,
          style: TextStyle(color: setTodoColor()),
        ),
      ),
    );
  }

  Color setTodoColor() {
    if (widget.isNight && widget.isTodoCheck) {
      return Colors.greenAccent[400];
    } else if (!widget.isNight && widget.isTodoCheck) {
      return Colors.greenAccent[400];
    } else if (!widget.isNight && !widget.isTodoCheck) {
      return Colors.black87;
    } else {
      return Colors.white60;
    }
  }
}
