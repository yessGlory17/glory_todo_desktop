import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/Pages/ProjectPage.dart';
import 'package:glory_todo_desktop/core/Manager/Manager.dart';

void main() {
  //CreateFile();
  runApp(MyApp());

  //createJSONFile("tablo.json");
  //getTabloFile();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProjectPage(),
    );
  }
}
