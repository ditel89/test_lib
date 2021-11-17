//import 'dart:html';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:container_lib/containerdata.dart';
// import 'package:container_lib/main.dart';
// import 'package:container_lib/text_style.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

// import 'package:fl_chart/fl_chart.dart';

import 'package:http/http.dart' as http;

import 'package:smart_arrays_peaks/smart_arrays_peaks.dart';

//import 'package:flutter/services.dart' show rootBundle;

class Ims {
  //final String id;
  final List ims;

  Ims({this.ims});

  factory Ims.fromJson(Map<String, dynamic> json) {
    return Ims(
      ims: json['ims'],
    );
  }
}

Future<Ims> readJson(String path) async {
  String response = await rootBundle.loadString(path);
  var tagsJson = json.decode(response);
  // var tagsJson = jsonDecode(response)['ims'].cast<Map<String, dynamic>>();
  // print(tagsJson.runtimeType);
  return Ims.fromJson(tagsJson);
  //return tagsJson.map((json) => tagsJson.from.Json(json)).toList();
}

String address = 'http://123.214.186.168:3810/';

// ignore: non_constant_identifier_names
Future<ContainerData> get_data(String comm, id) async {
  print('1. get data');
  final response = await http.get(address + comm + 'id=' + id);
  print(address + comm + 'id=' + id);
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ContainerData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  //return ContainerData.fromJson(jsonDecode(response.body));
}

// ignore: must_be_immutable
class DBDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        constraints: new BoxConstraints.expand(),
        color: new Color(0xFF736AB7),
        child: new Stack(
          children: <Widget>[
            _getBackground(),
            _getGradient(),
            _getContent(),
            //_getchart(),
            //_getchart2(),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _text_keti(String text) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _test_restful() {
    return ListView(
      children: <Widget>[
        Container(
          //padding: new EdgeInsets.fromLTRB(50, 500, 50, 30),
          child: FutureBuilder<ContainerData>(
            future: get_data('get_container_data_by_id?', 'id=5'),
            builder: (context, snapshot) {
              // print(snapshot.hasData);
              // print(snapshot.connectionState);
              // //
              //print(snapshot.hasData);
              if (snapshot.hasData) {
                print('Test 1');
                //print(snapshot.data);
                // print(snapshot.data.id);
                // print(snapshot.data.createdAT);
                return _text_keti(snapshot.data.date);
                //return Text('${snapshot.data.date}');
              } else if (snapshot.hasError) {
                print('Test 2');
                return Text("${snapshot.error}");
              }
              //}
              print('Test 3');
              return CircularProgressIndicator();
            },
          ),
        )
      ],
    );
  }

  Widget _test_restful1() {
    return Container(
      //padding: new EdgeInsets.fromLTRB(50, 500, 50, 30),
      child: Center(
        child: FutureBuilder<ContainerData>(
          //future: get_data('get_container_data_by_data_type_id?', .id),
          future: get_data('get_container_data_by_id?', '2'),
          builder: (context, snapshot) {
            // print(snapshot.hasData);
            // print(snapshot.connectionState);
            // //
            //print(snapshot.hasData);
            if (snapshot.hasData) {
              print('Test 1');
              //print(snapshot.data);
              // print(snapshot.data.id);
              // print(snapshot.data.createdAT);
              //return Text("restful");
              // return new Text(snapshot.data.date,
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 20,
              //         color: Colors.white));
              return DataTable(
                horizontalMargin: 12.0,
                columns: [
                  DataColumn(label: _text_keti('Name')),
                  DataColumn(label: _text_keti('Value')),
                  DataColumn(label: _text_keti('Name')),
                  DataColumn(label: _text_keti('Value'))
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(_text_keti('CAS No.')),
                    DataCell(_text_keti("111")),
                    DataCell(_text_keti('Chemical formula')),
                    DataCell(_text_keti("111")),
                  ]),
                  DataRow(cells: [
                    DataCell(_text_keti('Density')),
                    DataCell(_text_keti("111")),
                    DataCell(_text_keti('Vapor pressure')),
                    DataCell(_text_keti("111")),
                  ]),
                  DataRow(cells: [
                    DataCell(_text_keti('Boiling point')),
                    DataCell(_text_keti("111")),
                    DataCell(_text_keti('Melting point')),
                    DataCell(_text_keti("111")),
                  ]),

                  // DataRow(cells: [DataCell(_text_keti('A2'))]),
                  // DataRow(cells: [DataCell(_text_keti('A3'))]),
                  // DataRow(cells: [DataCell(_text_keti('A4'))]),
                ],
              );
              //return Text('${snapshot.data.date}');
              // return ListView(
              //   children: <Widget>[
              //     new Text('${snapshot.data.id}'),
              //   ],
              // );
            } else if (snapshot.hasError) {
              print('Test 2');
              return Text("${snapshot.error}");
            }
            //}
            print('Test 3');
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  Container _getBackground() {
    return new Container(
      padding: new EdgeInsets.fromLTRB(30.0, 72.0, 0.0, 50.0),
      child: new Text(
        "Digital Library",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),
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
          tileMode: TileMode.clamp,
        ),
      ),
      constraints: new BoxConstraints.expand(height: 300.0),
    );
  }

  Container _getGradient() {
    return new Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[
            new Color(0x00736AB7),
            new Color(0xFF736AB7),
          ],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  Widget _getContent() {
    //final _overviewTitle = "Overview".toUpperCase();
    return new ListView(
      padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 50.0),
      children: <Widget>[
        // new Row(
        //   ,
        //   horizontal: false,
        // ),
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 32.0, vertical: 128.0),
          //padding: new EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //new Text(_overviewTitle, style: Style.headerTextSt),
              // new Text(_overviewTitle,
              new Text("DB",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white)),
              new Separator(),
              new Image.asset(
                "img/db.png",
                height: 92.0,
                width: 92.0,
              ),
              new Separator(),
              //new Text(.description, style: Style.commonTextSt),
              new Text("Hazardous Material",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white)),
              new Separator(),
              _test_restful1(),
              new Separator(),
              //_getchart3(),
            ],
          ),
        )
      ],
    );
  }

  Widget _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new BackButton(color: Colors.white),
    );
  }
}

class Separator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 15.0),
      height: 2.0,
      width: 18.0,
      color: new Color(0xff00c6ff),
    );
  }
}

class ImsData {
  ImsData(this.xValue, this.yValue);
  final int xValue;
  final int yValue;
}
