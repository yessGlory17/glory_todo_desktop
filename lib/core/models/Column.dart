import 'package:glory_todo_desktop/core/models/Project.dart';

class ProjectColumn {
  int pColumnID;
  String pColumnHeader;
  int projectID;
  ProjectColumn(
      this.pColumnHeader); //Kategori eklerken kullan çünkü id dbden veriliyor

  //Kategorileri dbden okurken kullanılır.
  ProjectColumn.withID(this.pColumnID, this.pColumnHeader, this.projectID);

  

  @override
  String toString() {
    return 'Kategori{kategoriID: $pColumnID, kategoriBaslik: $pColumnHeader}';
  }
}
