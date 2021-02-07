import 'package:flutter/cupertino.dart';
import 'dart:math';

class Project {
  String projectID;
  String projectHeader;
  String projectUnicId;
  List<Column> columns = new List<Column>(5);
  var rand = new Random();
  Project(this.projectID,
      this.projectHeader) {} //Kategori eklerken kullan çünkü id dbden veriliyor

  Project.withId(this.projectID, this.projectHeader) {
    projectUnicId = rand.nextInt(1000000 - 10000).toString();
  }

  @override
  String toString() {
    return 'Kategori{kategoriID: $projectID, kategoriBaslik: $projectHeader}';
  }
}
