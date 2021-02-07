import 'package:glory_todo_desktop/core/models/Project.dart';
import 'dart:math';

class ProjectColumn {
  String projectUnicId = "alooo";
  String pColumnHeader;
  String punicColumnId;

  var rand = new Random();

  ProjectColumn(this.projectUnicId,
      this.pColumnHeader) {} //Kategori eklerken kullan çünkü id dbden veriliyor

  //Kategorileri dbden okurken kullanılır.
  ProjectColumn.withID(this.projectUnicId, this.pColumnHeader) {
    punicColumnId = rand.nextInt(1000000 - 10000).toString();
  }

  @override
  String toString() {
    return 'Kategori{kategoriID: $projectUnicId, kategoriBaslik: $pColumnHeader}';
  }
}
