import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  String todo;
  bool isTodoCheck;
  TodoWidget(this.todo, this.isTodoCheck);
  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    String todo = widget.todo;
    return Container(
      child: ListTile(
        leading: widget.isTodoCheck
            ? Icon(Icons.check_circle_outline)
            : Icon(Icons.stop_circle),
        title: Text(todo),
      ),
    );
  }
}
