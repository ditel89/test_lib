//import 'dart:js_util';

import 'package:flutter/material.dart';
//import 'package:flutter/semantics.dart';
import 'package:container_lib/bombHompageBody.dart';
import 'package:container_lib/drugHompageBody.dart';
import 'package:container_lib/drugdata.dart';
import 'package:container_lib/bombdata.dart';
// import 'package:container_lib/text_style.dart';
// import 'package:container_lib/detailpage.dart';
// import 'package:container_lib/data.dart';

void main() {
  //Routes.initRoutes();
  runApp(
    new MaterialApp(
      title: "KETI conatainer library Data",
      home: new HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: new Color(0xFF736AB7),
      body: new Column(
        children: <Widget>[
          new GradientAppBar("Hazardous Material Data"),
          new Title(
            color: Colors.white,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: new EdgeInsets.symmetric(
                        vertical: 50.0, horizontal: 35.0)),
                //Padding(
                //   padding: new EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 10.0)),
                Text(
                  "Explosive (" + bombDatas.length.toString() + ")",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          new BombHomePageBody(),
          new Title(
            color: Colors.white,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: new EdgeInsets.symmetric(
                        vertical: 50.0, horizontal: 35.0)),
                //Padding(
                //   padding: new EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 10.0)),
                Text(
                  "Drug (" + drugdatas.length.toString() + ")",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          new DrugHomePageBody(),
          // ketiText("DB"),
          // new DBHomePageBody(),
        ],
      ),
    );
  }

  Widget ketiText(String text) {
    return new Title(
      color: Colors.white,
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding:
                  new EdgeInsets.symmetric(vertical: 50.0, horizontal: 35.0)),
          //Padding(
          //   padding: new EdgeInsets.fromLTRB(16.0, 60.0, 16.0, 10.0)),
          Text(
            text,
            style: TextStyle(
                fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class GradientAppBar extends StatelessWidget {
  final String title;
  final double barHeight = 66.0;

  GradientAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return new Container(
      padding: new EdgeInsets.only(top: statusBarHeight),
      height: statusBarHeight + barHeight,
      child: new Center(
        child: new Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 40.0)),
      ),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3366FF),
              const Color(0xFF00CCFF),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.5, 0.0),
            stops: [0.0, 0.5],
            tileMode: TileMode.clamp),
      ),
    );
  }
}
