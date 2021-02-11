import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/Pages/TodosPage.dart';
import 'package:glory_todo_desktop/core/JsonManager/JsonManager.dart';
import 'package:glory_todo_desktop/core/components/TodoWidget.dart';
import 'package:glory_todo_desktop/core/models/Column.dart';
import 'package:glory_todo_desktop/core/models/Project.dart';
import 'package:glory_todo_desktop/core/models/Todo.dart';

/*

  BU SAYFADA KOLONLAR VE HER KOLONA AİT GÖREVLER YER ALIYOR.

 */

class ColumnWidget extends StatefulWidget {
  bool isNight;
  String tableHeader;
  int columnId;
  String columnName;
  int projectId;
  String projectName;
  ColumnWidget(this.isNight, this.tableHeader, this.projectId, this.projectName,
      this.columnId, this.columnName);

  @override
  _ColumnWidgetState createState() => _ColumnWidgetState();
}

class _ColumnWidgetState extends State<ColumnWidget> {
  var todoTextKey = GlobalKey<FormState>();
  var gorevEklemeKontrol = TextEditingController();
  int todoCounter = 0;
  String todoContent;
  Future<List<Todo>> gorevlerListe;
  void updateTodoList() {
    setState(() {
      gorevlerListe = findTodos(widget.projectId, widget.projectName,
          widget.columnId, widget.columnName);
    });
  }

  @override
  Widget build(BuildContext context) {
    gorevlerListe = findTodos(widget.projectId, widget.projectName,
        widget.columnId, widget.columnName);

    //findColumnTodos(widget.tableUnicId); //widget.tableHeader
    return Container(
      key: ValueKey(widget.projectName),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: 300,
      constraints: BoxConstraints(
        minHeight: 200,
      ),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: widget.isNight ? Colors.black12 : Colors.grey.shade300,

              blurRadius: 6,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
          color: widget.isNight ? Color(0xFF1f2024) : Color(0xFFd7d8de),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(widget.tableHeader,
                        style: TextStyle(
                          fontSize: 20,
                          color: widget.isNight ? Colors.white : Colors.black,
                        )),
                  ),
                ),
                // Positioned(
                //   top: -10,
                //   right: 0,
                //   child: IconButton(
                //     icon: Icon(
                //       Icons.edit,
                //       color: widget.isNight ? Colors.white54 : Colors.black54,
                //     ),
                //     onPressed: () {},
                //   ),
                // ),
              ],
            ),
          ),

          //Buraya Görevler Listesi gelmeli
          Container(
              width: 300,
              height: MediaQuery.of(context).size.height - 225,
              child: FutureBuilder(
                future: gorevlerListe,
                builder: (context, snapshot) {
                  List<Todo> listem = snapshot.data ?? [];
                  if (listem.length > 0) {
                    todoCounter = listem.length;
                    print("Görev :==> " + listem[0].todo);
                    return ListView.builder(
                        itemCount: listem.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TodoWidget(
                              listem[index].todo,
                              listem[index].isCheck,
                              widget.isNight,
                              widget.projectId,
                              widget.projectName,
                              widget.columnId,
                              widget.columnName,
                              listem[index].todoId,
                              updateTodoList);
                        });
                  } else {
                    print("Herhangi bir görev bulunamadı!");
                    return Center(
                        child: Text(
                      "Herhangi bir görev yok!",
                      style: TextStyle(
                          color:
                              widget.isNight ? Colors.white60 : Colors.black87),
                    ));
                  }
                },
              )),
          //En altta ekleme butonu bulunmalı
          Container(
              width: 200,
              height: 20,
              child: IconButton(
                  icon: Icon(Icons.add,
                      color: widget.isNight ? Colors.white : Colors.black),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: Text(
                              "Yeni Görev Ekle",
                              style: TextStyle(
                                  color: widget.isNight
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            content: Form(
                              key: todoTextKey,
                              child: TextFormField(
                                controller: gorevEklemeKontrol,
                                validator: (value) =>
                                    value != null ? null : "Bir görev giriniz.",
                                onSaved: (value) => todoContent = value,
                                style: TextStyle(
                                    color: widget.isNight
                                        ? Colors.white
                                        : Colors.black),
                                decoration: InputDecoration(
                                    hintText: "Görevi Giriniz",
                                    hintStyle: TextStyle(
                                        color: widget.isNight
                                            ? Colors.white
                                            : Colors.black)),
                              ),
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
                                      if (todoTextKey.currentState.validate()) {
                                        todoTextKey.currentState.save();

                                        addTodo(
                                            Todo(todoCounter + 1,
                                                gorevEklemeKontrol.text, false),
                                            widget.projectId,
                                            widget.projectName,
                                            widget.columnId,
                                            widget.columnName);

                                        gorevlerListe = findTodos(
                                            widget.projectId,
                                            widget.projectName,
                                            widget.columnId,
                                            widget.columnName);
                                        gorevEklemeKontrol.clear();
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  child: Container(
                                    child: Text(
                                      "Ekle",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        }); //SetState sonu
                  })),
        ],
      ),
    );
  }
}
