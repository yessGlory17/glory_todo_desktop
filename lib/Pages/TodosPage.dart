import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/core/JsonManager/JsonManager.dart';
import 'package:glory_todo_desktop/core/components/ColumnWidget.dart';
import 'package:glory_todo_desktop/core/models/Column.dart';
import 'dart:io';
import 'package:glory_todo_desktop/core/components/Table.dart';
import 'package:glory_todo_desktop/core/models/Todo.dart';

class TodosPage extends StatefulWidget {
  bool isNight;
  String projectName;
  int projectId;
  String projecName;
  final Function() updateProjectWidgets;
  TodosPage(this.isNight, this.projectName, this.projectId, this.projecName,
      this.updateProjectWidgets);

  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  var kontroller = TextEditingController();
  Future<List<ProjectColumn>> kolonListe;

  @override
  Widget build(BuildContext context) {
    print("Todos Page projectName => " + widget.projecName);
    int myIndex = 0;
    kolonListe = findColumn(widget.projectId,
        widget.projecName); //Buraya JSON üzerinden bulma fonksiyonu gelecek.
    kolonListe.then((value) => print("Uzunluk   " + value.toString()));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: widget.isNight ? Color(0xFF141518) : Colors.white,
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
          elevation: 0.4,
          //widget.isNight ? Color(0xFF141518) : Colors.white,
          actions: [
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                setState(() {
                  removeProject(widget.projectId, widget.projecName);
                  widget.updateProjectWidgets();
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
                          "Yeni Kolon Adı?",
                          style: TextStyle(
                              color:
                                  widget.isNight ? Colors.white : Colors.black),
                        ),
                        content: TextFormField(
                          controller: kontroller,
                          decoration: InputDecoration(
                              hintText: "Kolon Adını Giriniz",
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
                                          3, kontroller.text),
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
                Color(0xFF141518),
                Color(0xFF191b1f),
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
                              projects[index].columnName);
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
}
