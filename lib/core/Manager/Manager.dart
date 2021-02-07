import 'dart:io';

import 'package:glory_todo_desktop/core/models/Column.dart';
import 'package:glory_todo_desktop/core/models/Project.dart';
import 'package:glory_todo_desktop/core/models/Todo.dart';
import 'package:path_provider_windows/path_provider_windows.dart';

String tablo = "\\Tablo.txt";
String gorevler = "\\Gorevler.txt";
String kolonlar = "\\Kolonlar.txt";

final PathProviderWindows provider = PathProviderWindows();
//Bu fonksiyonu dosyadan bütün satırları okur ve geri tablo listesi döndürür.
Future<List<Project>> read() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + tablo;
  List<String> cont = File(path).readAsLinesSync();
  var tablolar = <Project>[];
  cont.forEach((element) {
    //print("e: " + element);
    List<String> l = element.split("#");
    Project yeni = new Project(l[0], l[1]);
    tablolar.add(yeni);
  });

  return tablolar;
}

//Dosya Oluştur
Future<void> CreateFile() async {
  await CreateTabloFile();
  await CreateKolonFile();
}

void CreateTabloFile() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + tablo;
  new File(path).createSync(recursive: true);

  print("Dosyalar oluşturuldu!");
}

void CreateKolonFile() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + kolonlar;
  new File(path).createSync(recursive: true);
  print("Dosyalar oluşturuldu!");
}

//Dosyaya Yaz
void WriteTablo(Project tabloEleman) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + tablo;
  File file = new File(path);
  String id = tabloEleman.projectID;
  String isim = tabloEleman.projectHeader;
  String unicId = tabloEleman.projectUnicId;
  file.writeAsStringSync("$id" + "#" + "$isim" + "#" + "$unicId" + "\n",
      mode: FileMode.append);
}

//Kolonu Dosyaya yazar
void WriteColumn(ProjectColumn kolonEleman) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + kolonlar;
  File file = new File(path);
  String id = kolonEleman.projectUnicId;
  String isim = kolonEleman.pColumnHeader;
  String columnUnicId = kolonEleman.punicColumnId;
  file.writeAsStringSync("$id" + "#" + "$isim" + "#" + "$columnUnicId" + "\n",
      mode: FileMode.append);
}

//GÖREVİ YAZ
//Kolonu Dosyaya yazar
void WriteTodo(Todo todoEleman) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + gorevler;
  File file = new File(path);
  String id = todoEleman.columnUnicId;
  String isim = todoEleman.todo;
  bool isCheck = todoEleman.isCheck;
  String todoUnicId = todoEleman.todoId;
  file.writeAsStringSync(
      "$id" + "#" + "$isim" + "#" + "$isCheck" + "#" + "$todoUnicId" + "\n",
      mode: FileMode.append);
}

//Kolonları Okuyup Liste Olarak Geri Döner
Future<List<Project>> readColumns() async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + tablo;
  List<String> cont = File(path).readAsLinesSync();
  var tablolar = <Project>[];
  cont.forEach((element) {
    //print("e: " + element);
    List<String> l = element.split("#");
    Project yeni = new Project(l[0], l[1]);
    tablolar.add(yeni);
  });

  return tablolar;
}

//FİND COLUMN WİTH NAME
Future<List<ProjectColumn>> findProjectColumns(String projectUnicId) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + kolonlar;
  List<String> cont = File(path).readAsLinesSync();
  var tablolar = <ProjectColumn>[];
  cont.forEach((element) {
    //print("e: " + element);
    List<String> l = element.split("#");
    if (projectUnicId == l[0]) {
      ProjectColumn yeni = new ProjectColumn(l[0], l[1]);
      print(
          "BULUNDU[Kolon] :=======================================================>  " +
              l[0]);
      tablolar.add(yeni);
    }
  });

  return tablolar;
}

Future<List<Todo>> findColumnTodos(String columnUnicId) async {
  String documentPath = await provider.getApplicationDocumentsPath();
  String path = documentPath + gorevler;
  List<String> cont = File(path).readAsLinesSync();
  var tablolar = <Todo>[];
  cont.forEach((element) {
    //print("e: " + element);
    List<String> l = element.split("#");
    if (columnUnicId == l[0]) {
      Todo yeni = new Todo(l[0], l[1]);
      print(
          "BULUNDU[Görev] :=======================================================>  " +
              l[0]);
      tablolar.add(yeni);
    }
  });

  return tablolar;
}

//Değişiklik yapılmış listeyi alır. Önce dosyanın içini tamamen siler ve listeyi tekrardan o dosyaya yazar.
Future<void> UpdateTodos(List<dynamic> updateList) {}
