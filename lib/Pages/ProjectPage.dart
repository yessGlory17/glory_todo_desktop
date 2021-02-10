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

  var projeBaslik = TextEditingController();
  int tablesIndexCount = 0;
  Future<List<Project>> tables = readProjects();

  void updateProjectsWidgets() {
    setState(() {
      tables = readProjects();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tables = readProjects();

    tables.then((value) => tablesIndexCount = value.length);
  }

  @override
  Widget build(BuildContext context) {
    double gridCount = MediaQuery.of(context).size.width / 300;
    print("PROJE SAYFASIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII");
    return Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          title: Image.asset(
            "assets/logo.png",
            width: 35,
            fit: BoxFit.contain,
            isAntiAlias: true,
          ),
          backgroundColor: isNight ? Color(0xFF141518) : Colors.white,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: isNight ? Colors.white54 : Colors.black54,
                ),
                onPressed: () {}),
            IconButton(
                icon: Icon(
                  Icons.nightlight_round,
                  color: isNight ? Colors.white54 : Colors.yellow.shade300,
                ),
                onPressed: () {
                  setState(() {
                    isNight = !isNight;
                  });
                })
          ],
        ),
        backgroundColor: Colors
            .transparent, //isNight ? Color(0xFF191b1f) : Color(0xFFE3E6EB),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color(0xFF0DC472),
          icon: Icon(Icons.add),
          label: Text(
            "Create",
            style: TextStyle(
                fontFamily: "Roboto",
                fontWeight: FontWeight.w400,
                fontSize: 18),
          ),
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
                                    tablesIndexCount + 1,
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
                                tables.then(
                                    (value) => tablesIndexCount = value.length);
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
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0xFF141518),
                  Color(0xFF191b1f),
                ])),
            child: FutureBuilder(
              future: tables,
              builder: (context, snapshot) {
                //print("SONUC : " + snapshot.data[0]);
                List<Project> projects = snapshot.data ?? [];
                print("PROJELER => " + projects.toString());
                if (projects.length > 0) {
                  print("PROJECT : " + projects[0].projectName);
                  tables.then((value) => tablesIndexCount = value.length);
                }
                return GridView.builder(
                  itemCount: projects.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridCount.round(),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return new TabloWidget(
                        isNight,
                        projects[index].projectName,
                        projects[index].projectID,
                        projects[index].projectName,
                        updateProjectsWidgets);
                    //print("YAZ :=> " + data.toString());
                  },
                );
              },
            )));
  }

  int _randomId() {
    var rand = Random().nextInt(1000000 - 10000);
    return rand;
  }
}
