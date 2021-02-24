import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/Pages/SettingsPage.dart';
import 'package:glory_todo_desktop/core/components/Table.dart';
import 'package:glory_todo_desktop/core/models/Column.dart';
import 'dart:convert';
import 'package:glory_todo_desktop/core/models/Todo.dart';
import 'package:glory_todo_desktop/core/models/Project.dart';
import 'package:glory_todo_desktop/core/models/Settings.dart';
import 'package:glory_todo_desktop/core/Lang/Lang.dart';
import 'dart:math';
import 'package:glory_todo_desktop/core/JsonManager/JsonManager.dart';
import 'package:page_transition/page_transition.dart';

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
  List<Settings> settings;

  void updateProjectsWidgets() {
    setState(() {
      tables = readProjects();
    });
  }

  void refreshSettings() {
    readSettings().then((value) {
      settings = value;
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
    List<Color> backgroundColorGradient =
        setModeColor(settings != null ? settings[0].colorMode : "Dark");
    refreshSettings();
    return Scaffold(
        appBar: AppBar(
          elevation: 0.2,
          title: Image.asset(
            "assets/logo.png",
            width: 35,
            fit: BoxFit.contain,
            isAntiAlias: true,
          ),
          backgroundColor: settings != null
              ? settings[0].colorMode == "Dark"
                  ? Color(0xFF141518)
                  : Color(0xFFedeef5)
              : Color(0xFF141518),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: settings != null
                      ? settings[0].colorMode == "Dark"
                          ? Colors.white54
                          : Colors.black54
                      : Colors.white54,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeftWithFade,
                          child: SettingsPage(isNight)));
                }),
            IconButton(
                icon: Icon(
                  Icons.nightlight_round,
                  color: settings != null
                      ? settings[0].colorMode == "Dark"
                          ? Colors.white54
                          : Colors.yellow.shade300
                      : Colors.white54,
                ),
                onPressed: () {
                  setState(() {
                    setChangeColorMode();
                    refreshSettings();
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
            settings != null
                ? settings[0].language == "English"
                    ? Lang.english["projectPageCreateButton"]
                    : Lang.turkce["projectPageCreateButton"]
                : "Create!",
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
                        settings != null
                            ? settings[0].language == "English"
                                ? Lang.english["newProjectHeader"]
                                : Lang.turkce["newProjectHeader"]
                            : "New Project Name?",
                        style: TextStyle(
                          color: settings != null
                              ? settings[0].colorMode == "Dark"
                                  ? Colors.white54
                                  : Colors.black54
                              : Colors.white54,
                        ),
                      ),
                      content: TextFormField(
                        controller: projeBaslik,
                        style: TextStyle(
                            color: isNight ? Colors.white : Colors.black),
                        decoration: InputDecoration(
                            hintText: "Proje Adını Giriniz",
                            hintStyle: TextStyle(
                              color: settings != null
                                  ? settings[0].colorMode == "Dark"
                                      ? Colors.white54
                                      : Colors.black54
                                  : Colors.white54,
                            )),
                      ),
                      backgroundColor: settings != null
                          ? settings[0].colorMode == "Dark"
                              ? geceOnPlan
                              : Color(0xFFf1f2f6)
                          : geceOnPlan,
                      actions: [
                        Center(
                          child: FlatButton(
                            color: Colors.green.shade400,
                            onPressed: () {
                              setState(() {
                                print("DİL TESTİİİİİİİİİ =============> " +
                                    Lang.turkce["projectPageCreateButton"]);
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
                                settings != null
                                    ? settings[0].language == "English"
                                        ? Lang
                                            .english["projectPageCreateButton"]
                                        : Lang.turkce["projectPageCreateButton"]
                                    : "Oluştur",
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
                  backgroundColorGradient[0], backgroundColorGradient[1]
                  // Color(0xFF141518),
                  // Color(0xFF191b1f),
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
                        updateProjectsWidgets,
                        refreshSettings,
                        this.settings);
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

  List<Color> setModeColor(String isNight) {
    if (settings != null) {
      switch (isNight) {
        case "Dark":
          {
            return [Color(0xFF141518), Color(0xFF191b1f)];
          }
          break;
        case "Light":
          {
            return [Color(0xFFedeef5), Color(0xFFe9eaf5)];
          }
          break;
      }
    } else {
      return [Color(0xFF141518), Color(0xFF191b1f)];
    }
  }
}
