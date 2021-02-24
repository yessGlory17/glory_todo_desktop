import 'package:flutter/material.dart';
import 'package:glory_todo_desktop/core/JsonManager/JsonManager.dart';
import 'package:glory_todo_desktop/core/models/Settings.dart';
import 'package:glory_todo_desktop/core/Lang/Lang.dart';

class SettingsPage extends StatefulWidget {
  bool isNight;
  String lang = "Türkçe";
  SettingsPage(this.isNight);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Settings> settings;

  void refreshSettings() {
    readSettings().then((value) {
      settings = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> backgroundColorGradient = setModeColor(widget.isNight);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        title: Image.asset(
          "assets/logo.png",
          width: 35,
          fit: BoxFit.contain,
          isAntiAlias: true,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: widget.isNight ? Colors.white70 : Color(0xFF212121),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [],
        backgroundColor: widget.isNight ? Color(0xFF141518) : Color(0xFFedeef5),
      ),
      backgroundColor: Colors.transparent,
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
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 500,
                height: 500,
                //color: Colors.blueAccent,
                child: Column(
                  children: <Widget>[
                    //Gece Gündüz Modu Ayarı
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          settings != null
                              ? settings[0].language == "English"
                                  ? Lang.english["settingsColorMode"]
                                  : Lang.turkce["settingsColorMode"]
                              : "Color Mode ",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              color: widget.isNight
                                  ? Colors.white60
                                  : Colors.black54),
                        ),
                        IconButton(
                          icon: Icon(Icons.nightlight_round),
                          color: widget.isNight
                              ? Colors.white54
                              : Colors.yellow.shade300,
                          iconSize: 20,
                          onPressed: () {
                            setState(() {
                              setChangeColorMode();
                              refreshSettings();
                            });
                          },
                        )
                      ],
                    ),

                    //Dil Ayarı
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          settings != null
                              ? settings[0].language == "English"
                                  ? Lang.english["settingsLangMode"]
                                  : Lang.turkce["settingsLangMode"]
                              : "Language Option :",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              color: widget.isNight
                                  ? Colors.white60
                                  : Colors.black54),
                        ),
                        RaisedButton(
                          color: Colors.transparent,
                          child: Text(
                              settings != null
                                  ? settings[0].language == "Turkish"
                                      ? "Turkish"
                                      : "English"
                                  : "English",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.w500,
                                  color: widget.isNight
                                      ? Colors.white60
                                      : Colors.black54)),
                          onPressed: () {
                            setState(() {
                              setLanguage();
                              refreshSettings();
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
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
