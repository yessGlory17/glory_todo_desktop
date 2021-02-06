import 'package:flutter/cupertino.dart';

class Project {
  String projectID;
  String projectHeader;
  List<Column> columns = new List<Column>(5);

  Project(this.projectID,
      this.projectHeader); //Kategori eklerken kullan çünkü id dbden veriliyor

  @override
  String toString() {
    return 'Kategori{kategoriID: $projectID, kategoriBaslik: $projectHeader}';
  }
}
