import 'package:flutter/material.dart';

class TodosPage extends StatefulWidget {
  String projectName;
  TodosPage(this.projectName);
  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Project : " + widget.projectName),
        elevation: 0.4,
      ),
    );
  }
}
