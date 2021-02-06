import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/core/Manager/Manager.dart';
import 'package:glory_todo_desktop/core/models/Column.dart';

class TodosPage extends StatefulWidget {
  bool isNight;
  String projectName;
  TodosPage(this.isNight, this.projectName);

  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  var kontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: widget.isNight ? Color(0xFF212121) : Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.redAccent),
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
      backgroundColor: widget.isNight ? Colors.black : Color(0xFFE3E6EB),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
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
                                WriteColumn(new ProjectColumn(
                                    widget.projectName, kontroller.text));

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
          }),
    );
  }
}
