import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/Pages/TodosPage.dart';
import 'package:glory_todo_desktop/core/Manager/Manager.dart';
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
  String tableUnicId;
  ColumnWidget(this.isNight, this.tableHeader, this.tableUnicId);
  Project n = new Project("1", "test");

  @override
  _ColumnWidgetState createState() => _ColumnWidgetState();
}

class _ColumnWidgetState extends State<ColumnWidget> {
  var gorevEklemeKontrol = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Future<List<Todo>> gorevlerListe = findColumnTodos(widget.tableHeader);
    return Container(
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
          color: widget.isNight ? Color(0xFF212121) : Colors.white,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(widget.tableHeader,
                style: TextStyle(
                  fontSize: 20,
                  color: widget.isNight ? Colors.white : Colors.black,
                )),
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
                    print("Görev :==> " + listem[0].todo);
                    return ListView.builder(
                        itemCount: listem.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TodoWidget(listem[index].todo,
                              listem[index].isCheck, widget.isNight);
                        });
                  } else {
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
                    setState(() {
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
                              content: TextFormField(
                                controller: gorevEklemeKontrol,
                                decoration: InputDecoration(
                                    hintText: "Görevi Giriniz",
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
                                        WriteTodo(Todo.withId(
                                            widget.tableHeader,
                                            gorevEklemeKontrol.text));

                                        gorevlerListe =
                                            findColumnTodos(widget.tableHeader);

                                        gorevEklemeKontrol.clear();
                                        Navigator.pop(context);
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
                          });
                    }); //SetState sonu
                  })),
          //BURASI PROGRESS BAR
          // Container(
          //   width: 200,
          //   margin: EdgeInsets.symmetric(vertical: 10),
          //   // decoration: BoxDecoration(
          //   //   boxShadow: [
          //   //     BoxShadow(
          //   //       color: Color(0x738ABFC7),

          //   //       blurRadius: 1,
          //   //       offset: Offset(0, 2), // changes position of shadow
          //   //     ),
          //   //   ],
          //   // ),
          //   child: LinearProgressIndicator(
          //     value: 0.5,
          //     backgroundColor: Color(0x4D131111),
          //     minHeight: 6,
          //     valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          //   ),
          // ),
        ],
      ),
    );
  }
}
