import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/Pages/TodosPage.dart';
import 'package:glory_todo_desktop/core/Manager/Manager.dart';
import 'package:glory_todo_desktop/core/models/Column.dart';
import 'package:glory_todo_desktop/core/models/Project.dart';
import 'package:glory_todo_desktop/core/models/Todo.dart';

class ColumnWidget extends StatefulWidget {
  bool isNight;
  String tableHeader;
  ColumnWidget(this.isNight, this.tableHeader);
  Project n = new Project("1", "test");

  @override
  _ColumnWidgetState createState() => _ColumnWidgetState();
}

class _ColumnWidgetState extends State<ColumnWidget> {
  var columnKontrol = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String tableHead = widget.tableHeader;
    Future<List<ProjectColumn>> gorevler = findProjectColumns("İLK TABLO");
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TodosPage(widget.isNight, widget.tableHeader)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        width: 250,
        constraints: BoxConstraints(minHeight: 150),
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
              child: Text(
                widget.tableHeader,
                style: TextStyle(
                  fontSize: 20,
                  color: widget.isNight ? Colors.white : Colors.black,
                ),
              ),
            ),
            Card(
              child: FutureBuilder(
                future: gorevler,
                builder: (context, snapshot) {
                  //print("SONUC : " + snapshot.data[0]);
                  List<ProjectColumn> projects = snapshot.data ?? [];
                  if (projects.length > 0) {
                    print("Column : " + projects[0].pColumnHeader);
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: projects.length,
                    itemBuilder: (BuildContext context, int index) {
                      return new ColumnWidget(
                          widget.isNight, projects[index].pColumnHeader);
                      //print("YAZ :=> " + data.toString());
                    },
                  );
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 250,
              height: 35,
              color: Colors.transparent,
              child: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: Text(
                              "Görev Ekle",
                              style: TextStyle(
                                  color: widget.isNight
                                      ? Colors.white
                                      : Colors.black),
                            ),
                            content: TextFormField(
                              controller: columnKontrol,
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
                                      WriteTodo(new Todo(widget.tableHeader,
                                          columnKontrol.text));

                                      //tables = readColumns();
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
            )
          ],
        ),
      ),
    );
  }
}
