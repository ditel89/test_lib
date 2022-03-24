//import 'dart:html';
import 'dart:convert';

import 'package:container_lib/graph.dart';
import 'package:flutter/material.dart';

import 'package:container_lib/drugdata.dart';
import 'package:container_lib/containerdata.dart';

// import 'package:container_lib/main.dart';
// import 'package:container_lib/text_style.dart';

import 'package:http/http.dart' as http;

//import 'package:flutter/services.dart' show rootBundle;

String address = 'http://123.214.186.168:3810/';

// ignore: non_constant_identifier_names
Future<ContainerData> getdrugdata(String comm, id) async {
  print('1. get data');
  final response = await http.get(Uri.parse(address + comm + 'id=' + id));
  print(address + comm + 'id=' + id);
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    return ContainerData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

// ignore: must_be_immutable
class DrugDetailPage extends StatelessWidget {
  final DrugData drugData;

  DrugDetailPage(this.drugData);
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

  Widget _getToolbar(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: new BackButton(color: Colors.white),
    );
  }

// ignore: non_constant_identifier_names

  Widget _getContent() {
    //final _overviewTitle = "Overview".toUpperCase();
    return new ListView(
      padding: new EdgeInsets.fromLTRB(0.0, 72.0, 0.0, 50.0),
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.symmetric(horizontal: 32.0, vertical: 128.0),
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
              new Text(drugData.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white)),
              new Separator(),
              new Image(
                image: new AssetImage(drugData.image),
                height: 150.0,
                width: 150.0,
              ),
              new Separator(),
              //new Text(.description, style: Style.commonTextSt),
              new Text(drugData.description,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white)),
              new Separator(),
              _get_drugdata(),
              new Separator(),
              IMSgraph(drugData.name),
              new Separator(),
            ],
          ),
        )
      ],
    );
  }

  Widget _text_keti(String text) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
    );
  }

  Widget _get_drugdata() {
    return Container(
      //padding: new EdgeInsets.fromLTRB(50, 500, 50, 30),
      child: Center(
        child: FutureBuilder<ContainerData>(
          //future: get_data('get_container_data_by_data_type_id?', .id),
          future: getdrugdata('get_container_data_by_id?', '2'),
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
                    DataCell(_text_keti(drugData.casno)),
                    DataCell(_text_keti('Chemical formula')),
                    DataCell(_text_keti(drugData.formula))
                  ]),
                  DataRow(cells: [
                    DataCell(_text_keti('Density')),
                    DataCell(_text_keti(drugData.density)),
                    DataCell(_text_keti('Vapor pressure')),
                    DataCell(_text_keti(drugData.vaporpressure))
                  ]),
                  DataRow(cells: [
                    DataCell(_text_keti('Boiling point')),
                    DataCell(_text_keti(drugData.boilingpoint)),
                    DataCell(_text_keti('Melting point')),
                    DataCell(_text_keti(drugData.meltingpoint))
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
