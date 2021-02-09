import 'package:glory_todo_desktop/core/models/Column.dart';
import 'package:glory_todo_desktop/core/models/Project.dart';
import 'package:glory_todo_desktop/core/models/Todo.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'dart:io';
import 'dart:convert';

final PathProviderWindows provider = PathProviderWindows();
//!!-----------------------------------OLUŞTURMA İŞLEMİ--------------------------------------------------
//Bertilen Adresde Json Dosyası oluşturma
void Setup() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  new File(path).createSync(recursive: true);

  //Temel bir json dosyası oluştur []
  List<Project> empty = [];
  String emptyListToString = jsonEncode(empty);
  File file = File(path);
  file.writeAsStringSync(emptyListToString, mode: FileMode.append);
  print("Dosya oluşturuldu");
}

//!!-----------------------------------OKUMA İŞLEMİ--------------------------------------------------
//Proje Okuma
Future<List<Project>> readProjects() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Project> liste = l.map<Project>((e) => Project.fromJson(e)).toList();
  print("LİSTEM =======> " + liste.toString());
  List<Project> dondurelecekListe = [];
  liste.forEach((element) {
    dondurelecekListe.add(element);
  });

  return dondurelecekListe;
}
//Projeden Kolon Okuma

//Kolondan Görev Okuma

//!!-----------------------------------EKLEME İŞLEMİ--------------------------------------------------
//Tablo Ekle
void addProject(Project newProject) async {
  String documentPath = await provider.getApplicationDocumentsPath();

  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> liste = jsonDecode(cont);
  liste.add(newProject);

  String newContent = jsonEncode(liste);
  File file = new File(path);
  file.writeAsStringSync(newContent);

  print("YAZILDI!");
}

//Tabloya Kolon Ekle
void addColumn(
    ProjectColumn newColumn, int projectId, String projectName) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  var liste = List<Project>();
  liste = l.map<Project>((e) => Project.fromJson(e)).toList();
  print("Kolon Listem ===>  " + liste[0].columns.toString());
  liste.forEach((element) {
    if ((element.projectID == projectId) &&
        (element.projectName == projectName)) {
      ProjectColumn addColumn = ProjectColumn.addColumnContructor(
          newColumn.columnId, newColumn.columnName);
      element.columns.add(addColumn as dynamic);
      print("Kolon Eklendi!!!");
    }
  });

  String newContent = jsonEncode(liste);
  File file = new File(path);
  file.writeAsStringSync(newContent);

  print("Eklendi!!!");
}

//Kolona Görev Ekle
void addTodo(Todo newTodo, int projectId, String projectName, int columnId,
    String columnName) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  var liste = List<Project>();
  liste = l.map<Project>((e) => Project.fromJson(e)).toList();
  print("Kolon Listem ===>  " + liste[0].columns.toString());
  liste.forEach((element) {
    if ((element.projectID == projectId) &&
        (element.projectName == projectName)) {
      List<ProjectColumn> findedColumns = element.columns
          .map<ProjectColumn>((e) => ProjectColumn.fromJson(e))
          .toList();

      for (int j = 0; j < findedColumns.length; j++) {
        Todo addTodo =
            Todo(findedColumns[j].todos.length + 1, newTodo.todo, false);
        findedColumns[j].todos.add(addTodo);
      }
      //element.columns.add(addColumn as dynamic);
      print("Görev Eklendi!!!");
    }
  });

  String newContent = jsonEncode(liste);
  File file = new File(path);
  file.writeAsStringSync(newContent);

  print("Eklendi!!!");
}
//!!-----------------------------------SİLME İŞLEMİ--------------------------------------------------

//Proje Sil
removeProject(Project project) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Project> projectList =
      l.map<Project>((e) => Project.fromJson(e)).toList();

  for (int i = 0; i < projectList.length; i++) {
    if ((projectList[i].projectID == project.projectID) &&
        (projectList[i].projectName == project.projectName)) {
      projectList.remove(projectList[i]);
    }
  }

  List<dynamic> removedList = projectList;
  String newContent = jsonEncode(removedList);
  File file = new File(path);

  file.writeAsStringSync(newContent);
}
//Tablodan Kolon Sil

//Kolondan Görev Sil

//!!-----------------------------------GÜNCELLEME İŞLEMİ--------------------------------------------------

//Proje Güncelle
updateProject(Project project) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Project> projectList =
      l.map<Project>((e) => Project.fromJson(e)).toList();

  for (int i = 0; i < projectList.length; i++) {
    if (projectList[i].projectID == project.projectID) {
      int findedIndex = projectList.indexOf(projectList[i]);
      Project newProject = Project(
          projectList[i].projectID, project.projectName, project.columns);
      projectList.removeAt(findedIndex);

      projectList.insert(findedIndex, newProject);
    }
  }

  List<dynamic> updatedList = projectList;
  String newContent = jsonEncode(updatedList);
  File file = new File(path);

  file.writeAsStringSync(newContent);
}
//Tabloda Kolonu Güncelle

//Kolondan Görev Güncelle [Bu aynı zamanda görevi tamamlama işlemi olarak kullanılabilir]

//!!-----------------------------------BULMA İŞLEMİ--------------------------------------------------

Future<List<ProjectColumn>> findColumn(
    int projectId, String projectName) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Project> projects = l.map<Project>((e) => Project.fromJson(e)).toList();
  List<ProjectColumn> returnList = [];
  for (int i = 0; i < projects.length; i++) {
    if ((projects[i].projectID == projectId) &&
        (projects[i].projectName == projectName)) {
      print("Kolonlar Bulundu ==============> " +
          jsonEncode(projects[i].columns[0].toString()));

      List<ProjectColumn> findedColumns = projects[i]
          .columns
          .map<ProjectColumn>((e) => ProjectColumn.fromJson(e))
          .toList();

      for (int j = 0; j < findedColumns.length; j++) {
        returnList.add(findedColumns[j]);
      }
    }
  }

  return returnList;
}

Future<List<Todo>> findTodos(
    int projectId, String projectName, int columnId, String columnName) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Project> projects = l.map<Project>((e) => Project.fromJson(e)).toList();
  List<Todo> returnList = [];
  for (int i = 0; i < projects.length; i++) {
    if ((projects[i].projectID == projectId) &&
        (projects[i].projectName == projectName)) {
      print("Kolonlar Bulundu ==============> " +
          jsonEncode(projects[i].columns[0].toString()));

      List<ProjectColumn> findedColumns = projects[i]
          .columns
          .map<ProjectColumn>((e) => ProjectColumn.fromJson(e))
          .toList();

      for (int j = 0; j < findedColumns.length; j++) {
        if ((findedColumns[j].columnId == columnId) &&
            (findedColumns[j].columnName == columnName)) {
          List<Todo> findedTodos = findedColumns[j]
              .todos
              .map<Todo>((e) => Todo.fromJson(e))
              .toList();
          //returnList.add()
          print("Görev Bulundu!");
          returnList = findedTodos;

          //findedTodos.forEach((element) {});
        }
      }
    }
  }

  return returnList;
}
