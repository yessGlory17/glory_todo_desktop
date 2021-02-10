import 'package:flutter/cupertino.dart';
import 'dart:math';

class Project {
  int projectID;
  String projectName;
  List<dynamic> columns;

  Project(this.projectID, this.projectName,
      this.columns) {} //Kategori eklerken kullan çünkü id dbden veriliyor

  Project.addNew(this.projectID, this.projectName) {
    columns = [];
  }

  factory Project.fromJson(dynamic json) {
    //print("Tip : " + json['tabloKolonlari'].toString());
    return Project(json['projectID'], json['projectName'], json['columns']);
  }

  Map<String, dynamic> toJson() =>
      {'projectID': projectID, 'projectName': projectName, 'columns': columns};
}
