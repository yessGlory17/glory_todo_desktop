import 'package:glory_todo_desktop/core/models/Project.dart';

class ProjectColumn {
  String projectName;
  String pColumnHeader;

  ProjectColumn(this.projectName,
      this.pColumnHeader); //Kategori eklerken kullan çünkü id dbden veriliyor

  //Kategorileri dbden okurken kullanılır.
  ProjectColumn.withID(this.projectName, this.pColumnHeader);

  @override
  String toString() {
    return 'Kategori{kategoriID: $projectName, kategoriBaslik: $pColumnHeader}';
  }
}
