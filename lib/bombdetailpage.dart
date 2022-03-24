//import 'dart:html';
import 'dart:convert';

import 'package:container_lib/graph.dart';
import 'package:container_lib/uploadIMSdata.dart';
import 'package:flutter/material.dart';

import 'package:container_lib/bombdata.dart';
import 'package:container_lib/containerdata.dart';
import 'package:container_lib/postFormfield.dart';
// import 'package:container_lib/main.dart';
// import 'package:container_lib/text_style.dart';

import 'package:http/http.dart' as http;

//import 'package:flutter/services.dart' show rootBundle;

String address = 'http://123.214.186.168:3810/';

String item;
// ignore: non_constant_identifier_names
Future<BombData> getbombdata(String comm, String id) async {
  print('1. get data');
  final response =
      await http.get(Uri.parse(address + comm + 'data_type_id=' + id));
  item = response.body;
  if (response.statusCode == 200) {
    return BombData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<ContainerData> getContainerdata(String comm, id) async {
  final response = await http.get(Uri.parse(address + comm + 'id=' + id));
  if (response.statusCode == 200) {
    return ContainerData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

// ignore: must_be_immutable
class BombDetailPage extends StatefulWidget {
  final BombData bombdata;

  BombDetailPage(this.bombdata);
  @override
  _BombDetailPageState createState() => _BombDetailPageState(bombdata);
}

class _BombDetailPageState extends State<BombDetailPage> {
  final BombData bombdata;
  _BombDetailPageState(this.bombdata);

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
            _getToolbar(context),
          ],
        ),
      ),
    );
  }

  // List<Color> gradientColors = [
  //   const Color(0xff23b6e6),
  //   const Color(0xff02d39a),
  // ];

  Container _getBackground() {
    return new Container(
      padding: new EdgeInsets.fromLTRB(30.0, 72.0, 0.0, 50.0),
      // child: new Text(
      //   "Digital Library",
      //   style: TextStyle(
      //       fontWeight: FontWeight.bold, fontSize: 50, color: Colors.white),
      // ),
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

  Widget _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new BackButton(color: Colors.white),
    );
  }

  Widget _getContent() {
    //final _overviewTitle = "Overview".toUpperCase();
    return new ListView(
      padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 50.0),
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          //padding: new EdgeInsets.fromLTRB(32.0, 0.0, 0.0, 0.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text("Digital Library",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 70,
                      color: Colors.white)),
              new Separator(),
              new Text(bombdata.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white)),
              new Separator(),
              new Image(
                image: new AssetImage(bombdata.image),
                height: 150.0,
                width: 150.0,
              ),
              new Separator(),
              //new Text(.description, style: Style.commonTextSt),
              new Text(bombdata.description,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white)),
              new Separator(),
              _get_bombdata(),
              new Separator(),
              IMSgraph(bombdata.name),
              new Separator(),
              PostFormfield(bombdata.id),
              new Separator(),
              //uploadIMSdata(),
              UploadIMSdata(bombdata.id),
              new Separator(),
            ],
          ),
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _text_keti(String text) {
    return Text(
      text ?? '',
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _get_bombdata() {
    return Container(
      //padding: new EdgeInsets.fromLTRB(50, 500, 50, 30),
      child: Center(
        child: FutureBuilder<BombData>(
          future:
              getbombdata('get_container_data_by_data_type_id?', bombdata.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print('snapshot data');
              print(snapshot.data.casno);
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
                    DataCell(_text_keti(snapshot.data.casno)),
                    DataCell(_text_keti('Chemical formula')),
                    DataCell(_text_keti(snapshot.data.chemicalformula))
                  ]),
                  DataRow(cells: [
                    DataCell(_text_keti('Density')),
                    DataCell(_text_keti(snapshot.data.density)),
                    DataCell(_text_keti('Vapor pressure')),
                    DataCell(_text_keti(snapshot.data.vaporpressure))
                  ]),
                  DataRow(cells: [
                    DataCell(_text_keti('Boiling point')),
                    DataCell(_text_keti(snapshot.data.boilingpoint)),
                    DataCell(_text_keti('Melting point')),
                    DataCell(_text_keti(snapshot.data.meltingpoint))
                  ]),
                  DataRow(cells: [
                    DataCell(_text_keti('Shock Sensitivity')),
                    DataCell(_text_keti(snapshot.data.shocksensitivity)),
                    DataCell(_text_keti('Friction Sensitivity')),
                    DataCell(_text_keti(snapshot.data.frictionsensitivity))
                  ]),
                  DataRow(cells: [
                    DataCell(_text_keti('Detonation Velocity')),
                    DataCell(_text_keti(snapshot.data.detonationvelocity)),
                    DataCell(_text_keti('RE Factor')),
                    DataCell(_text_keti(snapshot.data.refactor))
                  ]),
                ],
              );
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
}

// ignore: non_constant_identifier_names

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
