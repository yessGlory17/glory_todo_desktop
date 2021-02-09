import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/Pages/ProjectPage.dart';

import 'package:glory_todo_desktop/core/JsonManager/JsonManager.dart';

void main() {
  //Setup();
  runApp(MyApp());
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
