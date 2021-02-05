import 'package:flutter/material.dart';

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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: 250,
      height: 300,
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
          Text(widget.tableHeader,
              style: TextStyle(
                fontSize: 24,
                color: widget.isNight ? Colors.white : Colors.black,
              )),
        ],
      ),
    );
  }
}
