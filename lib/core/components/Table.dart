import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/Pages/TodosPage.dart';

class TabloWidget extends StatefulWidget {
  bool isNight;
  String tableHeader;
  TabloWidget(this.isNight, this.tableHeader);

  @override
  _TabloWidgetState createState() => _TabloWidgetState();
}

class _TabloWidgetState extends State<TabloWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TodosPage(widget.tableHeader)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        width: 250,
        height: 200,
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
                    fontSize: 24,
                    color: widget.isNight ? Colors.white : Colors.black,
                  )),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0x738ABFC7),

                    blurRadius: 6,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: LinearProgressIndicator(
                value: 0.5,
                backgroundColor: Color(0x4D131111),
                minHeight: 6,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
