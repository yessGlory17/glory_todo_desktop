import 'package:flutter/material.dart';

class ColumnPopUpMenu extends StatefulWidget {
  bool isNight;

  VoidCallback edit;
  VoidCallback remove;

  ColumnPopUpMenu(this.isNight, this.edit, this.remove);

  @override
  _ColumnPopUpMenuState createState() => _ColumnPopUpMenuState();
}

class _ColumnPopUpMenuState extends State<ColumnPopUpMenu> {
  Color setColor() {
    if (widget.isNight) {
      return Colors.white54;
    } else {
      return Colors.black54;
    }
  }

  void showMenuSelection(String value) {
    switch (value) {
      case 'edit':
        widget.edit();
        break;
      case 'remove':
        widget.remove();
        break;

      // Other cases for other menu options
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool night = widget.isNight;
    return PopupMenuButton<String>(
      color: widget.isNight ? Color(0xFF1f2024) : Color(0xFFd7d8de),
      onSelected: showMenuSelection,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'edit',
          child: IconButton(
            icon: Icon(Icons.edit),
            //color: night ? Colors.white54 : Colors.black54,
          ),
        ),
        const PopupMenuItem<String>(
          value: 'remove',
          child: IconButton(
            icon: Icon(Icons.delete),
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
