import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/core/components/Table.dart';
import 'package:glory_todo_desktop/core/models/Column.dart';
import 'dart:convert';
import 'package:glory_todo_desktop/core/models/Todo.dart';
import 'package:glory_todo_desktop/core/models/Project.dart';
import 'dart:math';
import 'package:glory_todo_desktop/core/JsonManager/JsonManager.dart';

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  bool isNight = true;
  Color geceArkaPlan = Colors.black;
  Color geceOnPlan = Color(0xFF212121);
  Future<List<Project>> tables = readProjects();

  var projeBaslik = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.4,
          title: Text(
            "Glory Todo Desktop",
            style: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w200,
              color: isNight ? Colors.white : Color(0xFF212121),
            ),
          ),
          backgroundColor: isNight ? Color(0xFF212121) : Colors.white,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.nightlight_round,
                  color: isNight ? Colors.white : Colors.yellow.shade300,
                ),
                onPressed: () {
                  setState(() {
                    isNight = !isNight;
                  });
                })
          ],
        ),
        backgroundColor: isNight ? Colors.black : Color(0xFFE3E6EB),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF212121),
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return new AlertDialog(
                      title: Text(
                        "Yeni Proje Adı?",
                        style: TextStyle(
                            color: isNight ? Colors.white : Colors.black),
                      ),
                      content: TextFormField(
                        controller: projeBaslik,
                        decoration: InputDecoration(
                            hintText: "Proje Adını Giriniz",
                            hintStyle: TextStyle(
                                color: isNight ? Colors.white : Colors.black)),
                      ),
                      backgroundColor: isNight ? geceOnPlan : Color(0xFFf1f2f6),
                      actions: [
                        Center(
                          child: FlatButton(
                            color: Colors.green.shade400,
                            onPressed: () {
                              setState(() {
                                addProject(new Project(
                                    1,
                                    projeBaslik.text,
                                    List.generate(
                                        0,
                                        (index) => ProjectColumn(
                                            1,
                                            "",
                                            List.generate(
                                                0,
                                                (index) =>
                                                    Todo(1, "", false))))));

                                tables = readProjects();
                                print("T ================>    " +
                                    tables.toString());
                                projeBaslik.clear();
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              child: Text(
                                "Oluştur",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  });
            });
          },
        ),
        body: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: FutureBuilder(
                future: tables,
                builder: (context, snapshot) {
                  //print("SONUC : " + snapshot.data[0]);
                  List<Project> projects = snapshot.data ?? [];
                  print("PROJELER => " + projects.toString());
                  if (projects.length > 0) {
                    print("PROJECT : " + projects[0].projectName);
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: projects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new TabloWidget(
                          isNight,
                          projects[index].projectName,
                          projects[index].projectID,
                          projects[index].projectName);
                      //print("YAZ :=> " + data.toString());
                    },
                  );
                },
              ),
            )
          ],
        ));
  }

  int _randomId() {
    var rand = Random().nextInt(1000000 - 10000);
    return rand;
  }
}
