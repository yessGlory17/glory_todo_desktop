import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/core/GloryIcons/GloryIcons.dart';

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
        leading: IconButton(
          icon: Icon(
            widget.isTodoCheck
                ? GloryIcons.check_circle
                : GloryIcons.circle_empty,
            color: widget.isNight ? Colors.white60 : Colors.black87,
          ),
          onPressed: () {
            setState(() {
              widget.isTodoCheck != widget.isNight;
              print("B  A S I L D I" + widget.isTodoCheck.toString());
            });
          },
        ),
        title: Text(
          todo,
          style: TextStyle(
              color: widget.isNight ? Colors.white60 : Colors.black87),
        ),
      ),
    );
  }
}
