import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/core/JsonManager/JsonManager.dart';
import 'package:glory_todo_desktop/core/components/ColumnWidget.dart';
import 'package:glory_todo_desktop/core/models/Column.dart';
import 'dart:io';
import 'package:glory_todo_desktop/core/components/Table.dart';
import 'package:glory_todo_desktop/core/models/Todo.dart';
import 'package:glory_todo_desktop/core/models/Project.dart';

class TodosPage extends StatefulWidget {
  bool isNight;
  String projectName;
  int projectId;
  String projecName;

  final Function() updateProjectWidgets;
  final Function() updateProjectProgressBar;
  TodosPage(this.isNight, this.projectName, this.projectId, this.projecName,
      this.updateProjectWidgets, this.updateProjectProgressBar);

  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  var kontroller = TextEditingController();
  Future<List<ProjectColumn>> kolonListe;
  int kolonSayac = 0;
  String newProjectName;
  var projeAdiDuzenlemeKontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.updateProjectProgressBar();
  }

  void updateColumns() {
    setState(() {
      kolonListe = findColumn(widget.projectId, widget.projecName);
    });
  }

  void back() {
    setState(() {
      widget.updateProjectWidgets();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Todos Page projectName => " + widget.projecName);
    int myIndex = 0;
    kolonListe = findColumn(widget.projectId,
        widget.projecName); //Buraya JSON üzerinden bulma fonksiyonu gelecek.
    kolonListe.then((value) => print("Uzunluk   " + value.toString()));
    List<Color> backgroundColorGradient = setModeColor(widget.isNight);
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              widget.isNight ? Color(0xFF141518) : Color(0xFFedeef5),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: widget.isNight ? Colors.white70 : Color(0xFF212121),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            "Project : " + widget.projectName,
            style: TextStyle(
              fontFamily: "Roboto",
              fontWeight: FontWeight.w400,
              color: widget.isNight ? Colors.white : Color(0xFF212121),
            ),
          ),
          elevation: 0.2,
          //widget.isNight ? Color(0xFF141518) : Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              color: widget.isNight ? Colors.white54 : Colors.black54,
              onPressed: () {
                setState(() {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return new AlertDialog(
                          title: Text(
                            "Proje Adını Düzenle",
                            style: TextStyle(
                                color: widget.isNight
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          content: TextFormField(
                            style: TextStyle(
                                color: widget.isNight
                                    ? Colors.white
                                    : Colors.black),
                            controller: projeAdiDuzenlemeKontroller,
                            decoration: InputDecoration(
                                hintText: widget.projecName,
                                hintStyle: TextStyle(
                                    color: widget.isNight
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                          backgroundColor: widget.isNight
                              ? Color(0xFF212121)
                              : Color(0xFFf1f2f6),
                          actions: [
                            Center(
                              child: FlatButton(
                                color: Colors.green.shade400,
                                onPressed: () {
                                  setState(() {
                                    updateProject(Project.addNew(
                                        widget.projectId,
                                        projeAdiDuzenlemeKontroller.text));
                                    //tables = readColumns();
                                    widget.updateProjectWidgets();
                                    updateColumns();
                                    projeAdiDuzenlemeKontroller.clear();
                                    widget.updateProjectProgressBar();
                                    Navigator.pop(context);
                                    back();
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
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                setState(() {
                  removeProject(widget.projectId, widget.projecName);
                  widget.updateProjectWidgets();
                  widget.updateProjectProgressBar();
                  Navigator.pop(context);
                });
              },
            ),
            IconButton(
                icon: Icon(
                  Icons.nightlight_round,
                  color: widget.isNight ? Colors.white : Colors.yellow.shade300,
                ),
                onPressed: () {
                  setState(() {
                    widget.isNight = !widget.isNight;
                  });
                })
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.add),
            label: Text("New"),
            onPressed: () {
              setState(() {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: Text(
                          "New Column Name?",
                          style: TextStyle(
                              color:
                                  widget.isNight ? Colors.white : Colors.black),
                        ),
                        content: TextFormField(
                          style: TextStyle(
                              color:
                                  widget.isNight ? Colors.white : Colors.black),
                          controller: kontroller,
                          decoration: InputDecoration(
                              hintText: "New column name",
                              hintStyle: TextStyle(
                                  color: widget.isNight
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        backgroundColor: widget.isNight
                            ? Color(0xFF212121)
                            : Color(0xFFf1f2f6),
                        actions: [
                          Center(
                            child: FlatButton(
                              color: Colors.green.shade400,
                              onPressed: () {
                                setState(() {
                                  addColumn(
                                      new ProjectColumn.addColumnContructor(
                                          kolonSayac + 1, kontroller.text),
                                      widget.projectId,
                                      widget.projecName);

                                  //tables = readColumns();
                                  kolonListe = findColumn(
                                      widget.projectId, widget.projecName);
                                  kontroller.clear();

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
            }),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                // Color(0xFF141518),
                // Color(0xFF191b1f),
                backgroundColorGradient[0], backgroundColorGradient[1]
              ])),
          child: Row(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                constraints: BoxConstraints(
                  minHeight: 200,
                  maxHeight: MediaQuery.of(context).size.height - 50,
                ),
                child: FutureBuilder(
                  future: kolonListe ?? [],
                  builder: (context, snapshot) {
                    //print("SONUC : " + snapshot.data[0]);
                    List<ProjectColumn> projects = snapshot.data ?? [];
                    if (projects.length > 0) {
                      print("Column : " + projects[0].columnName);
                      kolonSayac = projects.length;
                      return ListView.builder(
                        key: ValueKey(projects[myIndex].columnName),
                        scrollDirection: Axis.horizontal,
                        itemCount: projects.length,
                        itemBuilder: (BuildContext context, int index) {
                          //Buradaki Tablo Widget Column Widget İle Değiştirilecek.
                          return new ColumnWidget(
                              widget.isNight,
                              projects[index].columnName,
                              widget.projectId,
                              widget.projectName,
                              projects[index].columnId,
                              projects[index].columnName,
                              updateColumns);
                          //print("YAZ :=> " + data.toString());
                        },
                      );
                    } else {
                      return new Center(
                        child: Text(
                          "Herhangi bir kolon bulunamadı!",
                          style: TextStyle(
                              color: widget.isNight
                                  ? Colors.white60
                                  : Colors.black87),
                        ),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  _updateMyItems(oldInd, newInd) {
    if (newInd > oldInd) {
      newInd -= 1;
    }

    final items = kolonListe.then((value) => value.removeAt(oldInd));

    kolonListe.then((value) => value.insert(newInd, (items as ProjectColumn)));
  }

  List<Color> setModeColor(bool isNight) {
    switch (isNight) {
      case true:
        {
          return [Color(0xFF141518), Color(0xFF191b1f)];
        }
        break;
      case false:
        {
          return [Color(0xFFedeef5), Color(0xFFe9eaf5)];
        }
        break;
    }
  }
}
