import 'package:glory_todo_desktop/core/models/Column.dart';
import 'package:glory_todo_desktop/core/models/Project.dart';
import 'package:glory_todo_desktop/core/models/Todo.dart';
import 'package:glory_todo_desktop/core/models/Settings.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'dart:io';
import 'dart:convert';

final PathProviderWindows provider = PathProviderWindows();
//!!-----------------------------------OLUŞTURMA İŞLEMİ--------------------------------------------------

void ExistJson() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String settingsPath = documentPath + "\\GloryTodoDesktop\\settings.json";
  if (!await File(path).exists()) {
    Setup();
  }

  if (!await File(settingsPath).exists()) {
    CreateSettingsFile();
  }
}

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

void CreateSettingsFile() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\settings.json";
  new File(path).createSync(recursive: true);

  //Temel bir json dosyası oluştur []
  List<Project> empty = [];
  String emptyListToString = jsonEncode(empty);
  File file = File(path);
  file.writeAsStringSync(emptyListToString, mode: FileMode.append);
  print("Dosya oluşturuldu");

  addDefaultSettings();
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

//Read Settings
Future<List<Settings>> readSettings() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\settings.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Settings> liste = l.map<Settings>((e) => Settings.fromJson(e)).toList();
  print("LİSTEM =======> " + liste.toString());
  List<Settings> dondurelecekListe = [];
  liste.forEach((element) {
    dondurelecekListe.add(element);
  });

  return dondurelecekListe;
}

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
        if ((findedColumns[j].columnId == columnId) &&
            (findedColumns[j].columnName == columnName)) {
          Todo addTodo =
              Todo(findedColumns[j].todos.length + 1, newTodo.todo, false);
          if (!findedColumns.contains(addTodo)) {
            findedColumns[j].todos.add(addTodo);
          }
        }
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

//Add Default Settings
void addDefaultSettings() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\settings.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  var liste = List<Settings>();
  //liste = l.map<Settings>((e) => Settings.fromJson(e)).toList();

  liste.add(Settings("Dark", "English"));

  String newContent = jsonEncode(liste);
  File file = new File(path);
  file.writeAsStringSync(newContent);

  print("Eklendi!!!");
}
//!!-----------------------------------SİLME İŞLEMİ--------------------------------------------------

//Proje Sil
removeProject(int projectId, String projectName) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Project> projectList =
      l.map<Project>((e) => Project.fromJson(e)).toList();

  for (int i = 0; i < projectList.length; i++) {
    if ((projectList[i].projectID == projectId) &&
        (projectList[i].projectName == projectName)) {
      projectList.remove(projectList[i]);
    }
  }

  List<dynamic> removedList = projectList;
  String newContent = jsonEncode(removedList);
  File file = new File(path);

  file.writeAsStringSync(newContent);
}

//Tablodan Kolon Sil
removeColumn(
    int projectId, String projectName, int columnId, String columnName) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Project> projectList =
      l.map<Project>((e) => Project.fromJson(e)).toList();
  List<ProjectColumn> findedColumns;
  for (int i = 0; i < projectList.length; i++) {
    if ((projectList[i].projectID == projectId) &&
        (projectList[i].projectName == projectName)) {
      findedColumns = projectList[i]
          .columns
          .map<ProjectColumn>((e) => ProjectColumn.fromJson(e))
          .toList();
      for (int j = 0; j < findedColumns.length; j++) {
        if ((findedColumns[j].columnId == columnId) &&
            (findedColumns[j].columnName == columnName)) {
          projectList[i].columns.remove(projectList[i].columns[j]);
        }
      }
      //projectList.remove(projectList[i]);
    }
  }

  List<dynamic> removedList = projectList;
  String newContent = jsonEncode(removedList);
  File file = new File(path);

  file.writeAsStringSync(newContent);
}
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
      Project newProject = Project(projectList[i].projectID,
          project.projectName, projectList[i].columns);
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
updateColumn(int projectId, String projectName, int columnId, String columnName,
    String newColumnName) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Project> projects = l.map<Project>((e) => Project.fromJson(e)).toList();
  List<Todo> returnList = [];

  int findedProjectIndex, findedColumnIndex, findedTodoIndex;

  List<ProjectColumn> findedColumns;
  List<Todo> findedTodos;
  ProjectColumn sample;
  Project sampleProj;
  for (int i = 0; i < projects.length; i++) {
    if ((projects[i].projectID == projectId) &&
        (projects[i].projectName == projectName)) {
      print("Kolonlar Bulundu ==============> " +
          jsonEncode(projects[i].columns[0].toString()));
      sampleProj = projects[i];
      findedProjectIndex = projects.indexOf(projects[i]);
      findedColumns = projects[i]
          .columns
          .map<ProjectColumn>((e) => ProjectColumn.fromJson(e))
          .toList();

      for (int j = 0; j < findedColumns.length; j++) {
        if ((findedColumns[j].columnId == columnId) &&
            (findedColumns[j].columnName == columnName)) {
          sample = findedColumns[j];
          findedColumnIndex = findedColumns.indexOf(findedColumns[j]);

          ProjectColumn updatedColumn =
              ProjectColumn(columnId, newColumnName, findedColumns[j].todos);
          findedColumns.removeAt(findedColumnIndex);
          findedColumns.insert(findedColumnIndex, updatedColumn);

          sample = findedColumns[j];
          findedColumnIndex = findedColumns.indexOf(findedColumns[j]);
          findedTodos = findedColumns[j]
              .todos
              .map<Todo>((e) => Todo.fromJson(e))
              .toList();

          //findedTodos.forEach((element) {});
        }
      }
    }
  }

  //Nasıl yeniden bir döküman oluşturup yazdıracağım!
  ProjectColumn k1 =
      ProjectColumn(sample.columnId, sample.columnName, findedTodos);
  List<ProjectColumn> updateColumns = await findedColumns;
  updateColumns.removeAt(findedColumnIndex);
  updateColumns.insert(findedColumnIndex, k1);
  List<Project> updatedList = await projects;

  Project p1 =
      Project(sampleProj.projectID, sampleProj.projectName, updateColumns);
  updatedList.removeAt(findedProjectIndex);
  updatedList.insert(findedProjectIndex, p1);
  String newContent = jsonEncode(updatedList);
  File file = new File(path);

  file.writeAsStringSync(newContent);
}

//Kolondan Görev Güncelle [Bu aynı zamanda görevi tamamlama işlemi olarak kullanılabilir]
updateTodo(int projectId, String projectName, int columnId, String columnName,
    int todoId, String todo) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Project> projects = l.map<Project>((e) => Project.fromJson(e)).toList();
  List<Todo> returnList = [];

  int findedProjectIndex, findedColumnIndex, findedTodoIndex;

  List<ProjectColumn> findedColumns;
  List<Todo> findedTodos;
  ProjectColumn sample;
  Project sampleProj;
  for (int i = 0; i < projects.length; i++) {
    if ((projects[i].projectID == projectId) &&
        (projects[i].projectName == projectName)) {
      print("Kolonlar Bulundu ==============> " +
          jsonEncode(projects[i].columns[0].toString()));
      sampleProj = projects[i];
      findedProjectIndex = projects.indexOf(projects[i]);
      findedColumns = projects[i]
          .columns
          .map<ProjectColumn>((e) => ProjectColumn.fromJson(e))
          .toList();

      for (int j = 0; j < findedColumns.length; j++) {
        if ((findedColumns[j].columnId == columnId) &&
            (findedColumns[j].columnName == columnName)) {
          sample = findedColumns[j];
          findedColumnIndex = findedColumns.indexOf(findedColumns[j]);
          findedTodos = findedColumns[j]
              .todos
              .map<Todo>((e) => Todo.fromJson(e))
              .toList();

          for (int k = 0; k < findedTodos.length; k++) {
            if ((findedTodos[k].todoId == todoId) &&
                (findedTodos[k].todo == todo)) {
              findedTodoIndex = findedTodos.indexOf(findedTodos[k]);
              bool isNewCheck = !findedTodos[k].isCheck;
              findedTodos.removeAt(findedTodoIndex);
              Todo updatedTodo = Todo(todoId, todo, isNewCheck);
              findedTodos.insert(findedTodoIndex, updatedTodo);
              print("Bulundu ===============================>    " +
                  findedTodos[k].todo);
            }
          }
          //findedTodos.forEach((element) {});
        }
      }
    }
  }

  //Nasıl yeniden bir döküman oluşturup yazdıracağım!
  ProjectColumn k1 =
      ProjectColumn(sample.columnId, sample.columnName, findedTodos);
  List<ProjectColumn> updateColumns = await findedColumns;
  updateColumns.removeAt(findedColumnIndex);
  updateColumns.insert(findedColumnIndex, k1);
  List<Project> updatedList = await projects;

  Project p1 =
      Project(sampleProj.projectID, sampleProj.projectName, updateColumns);
  updatedList.removeAt(findedProjectIndex);
  updatedList.insert(findedProjectIndex, p1);
  String newContent = jsonEncode(updatedList);
  File file = new File(path);

  file.writeAsStringSync(newContent);
}

//Update Settings

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
      // if (projects.length > 0) {
      //   print("Kolonlar Bulundu ==============> " +
      //       jsonEncode(projects[i].columns[0].toString()));
      // }

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

//!!-----------------------------------SIRALAMA İŞLEMİ--------------------------------------------------

//Proje Listesini al
//İndexine göre sırala
Future<void> sortProjects(oldIndex, newIndex) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Project> projectList =
      l.map<Project>((e) => Project.fromJson(e)).toList();

  if (projectList.length >= oldIndex && projectList.length >= newIndex) {
    Project newIndexProject = projectList[newIndex];
    Project oldIndexProject = projectList[oldIndex];

    projectList.removeAt(newIndex);
    projectList.insert(newIndex, oldIndexProject);
    projectList.removeAt(oldIndex);
    projectList.insert(oldIndex, newIndexProject);
  }
  List<dynamic> updatedList = projectList;
  String newContent = jsonEncode(updatedList);
  File file = new File(path);

  file.writeAsStringSync(newContent);
}

//!!-----------------------------------GÖREVLERİ SAYMA İŞLEMİ--------------------------------------------------

Future<List<int>> countTodos(int projectId, String projectName) async {
  int checkedTodoCounter = 0;
  int noneCheckedTodoCounter = 0;
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\storage.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Project> projects = l.map<Project>((e) => Project.fromJson(e)).toList();
  List<Todo> returnList = [];
  for (int i = 0; i < projects.length; i++) {
    if ((projects[i].projectID == projectId) &&
        (projects[i].projectName == projectName)) {
      List<ProjectColumn> findedColumns = projects[i]
          .columns
          .map<ProjectColumn>((e) => ProjectColumn.fromJson(e))
          .toList();

      for (int j = 0; j < findedColumns.length; j++) {
        List<Todo> findedTodos =
            findedColumns[j].todos.map<Todo>((e) => Todo.fromJson(e)).toList();
        //returnList.add()

        for (int y = 0; y < findedTodos.length; y++) {
          if (findedTodos[y].isCheck == true) {
            checkedTodoCounter++;
          } else {
            noneCheckedTodoCounter++;
          }
        }

        //findedTodos.forEach((element) {});

      }
    }
  }
  List<int> todoCounterList = [checkedTodoCounter, noneCheckedTodoCounter];
  return todoCounterList;
}

//!Settings Set Functions

void setChangeColorMode() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\settings.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Settings> settingsList =
      l.map<Settings>((e) => Settings.fromJson(e)).toList();
  Settings newSettings;
  if (settingsList[0].colorMode == "Dark") {
    newSettings = Settings("Light", settingsList[0].language);
  } else {
    newSettings = Settings("Dark", settingsList[0].language);
  }

  settingsList.remove(settingsList[0]);
  settingsList.add(newSettings);

  List<dynamic> removedList = settingsList;
  String newContent = jsonEncode(removedList);
  File file = new File(path);

  file.writeAsStringSync(newContent);
}

void setLanguage() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + "\\GloryTodoDesktop\\settings.json";
  String cont = File(path).readAsStringSync();
  List<dynamic> l = jsonDecode(cont);
  List<Settings> settingsList =
      l.map<Settings>((e) => Settings.fromJson(e)).toList();
  Settings newSettings;
  if (settingsList[0].language == "English") {
    newSettings = Settings(settingsList[0].colorMode, "Turkish");
  } else {
    newSettings = Settings(settingsList[0].colorMode, "English");
  }

  settingsList.remove(settingsList[0]);
  settingsList.add(newSettings);

  List<dynamic> removedList = settingsList;
  String newContent = jsonEncode(removedList);
  File file = new File(path);

  file.writeAsStringSync(newContent);
}


getLanguage() async{
  
}