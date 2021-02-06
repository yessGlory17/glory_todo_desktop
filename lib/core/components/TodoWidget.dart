import 'package:flutter/material.dart';

class TodoWidget extends StatefulWidget {
  bool isNight;
  String todo;
  bool isTodoCheck;
  TodoWidget(this.todo, this.isTodoCheck, this.isNight);
  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    String todo = widget.todo;
    return Card(
      color: widget.isNight ? Colors.black : Color(0xFFf1f2f6),
      child: ListTile(
        leading: widget.isTodoCheck
            ? Icon(Icons.check_circle_outline)
            : Icon(Icons.stop_circle),
        title: Text(
          todo,
          style: TextStyle(
              color: widget.isNight ? Colors.white60 : Colors.black87),
        ),
      ),
    );
  }
}
