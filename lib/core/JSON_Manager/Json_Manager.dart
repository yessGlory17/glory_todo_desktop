import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'dart:async';
import 'dart:convert';

//Tablo dosyasını bul.
//Tablo dosyasını ekle
String fileDirectory;
final PathProviderWindows provider = PathProviderWindows();

void createJSONFile(String filename) async {
  // Create a new directory, recursively creating non-existent directories.
  var a = await provider.getApplicationDocumentsPath();

  var p = a + "\\" + filename;
  var b = new File(p).createSync();
  fileDirectory = p;
  print("Bu P Directory : => " + p.toString());
}

Future getTabloFile() async {
  var a = await provider.getApplicationDocumentsPath();
  final String res = await rootBundle.loadString(fileDirectory);
  String sonuc = await json.decode(res);
  print("Sonuc : " + sonuc);
}

//Oluştur

//Oku

//Yaz
