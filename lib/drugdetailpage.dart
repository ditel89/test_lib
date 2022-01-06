//import 'dart:html';
import 'dart:convert';

import 'package:container_lib/graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:container_lib/drugdata.dart';
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
  final response = await http.get(Uri.parse(address + comm + 'id=' + id));
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

  Widget _getchart() {
    return Container(
      //padding: new EdgeInsets.fromLTRB(50, 500, 50, 30),
      child: Center(
        child: FutureBuilder(
          future: readJson('data/' + drugData.name + '.json'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data.ims.runtimeType);
              var ims = snapshot.data.ims;
              var data = ims.map((x) => int.parse(x)).toList();
              List<int> yValues = [...data];
              print("find peaks");
              var peak = findPeaks(yValues, -8100000, -7000000);
              print(peak);
              print(peak[0][1]);
              List<ImsData> xydata = <ImsData>[];
              for (int i = 0; i < yValues.length; i++) {
                xydata.add(ImsData(i, yValues[i]));
              }
              return Container(
                //padding: new EdgeInsets.fromLTRB(50, 300, 50, 30),
                child: new Stack(
                  children: <Widget>[
                    SfCartesianChart(
                      //title: _text_keti("Ion Mobility Spectrometry"),
                      title: ChartTitle(
                        text: "Ion Mobility Spectrometry",
                        backgroundColor: Colors.lightGreen,
                        borderColor: Colors.lightGreen,
                        borderWidth: 2,
                        // Aligns the chart title to left
                        alignment: ChartAlignment.near,
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      backgroundColor: Colors.white,
                      primaryXAxis: CategoryAxis(plotBands: <PlotBand>[
                        PlotBand(
                          text: drugData.name + ' Detect',
                          textAngle: 0,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                          color: Colors.white,
                          borderColor: Colors.red,
                          borderWidth: 3,
                          verticalTextPadding: '30%',
                          isVisible: true,
                          start: peak[0][1] - 6,
                          end: peak[0][1] + 6,
                        )
                      ]),
                      primaryYAxis: NumericAxis(
                        minimum: -8600000,
                        maximum: -7600000,
                      ),
                      trackballBehavior: TrackballBehavior(
                        enable: true,
                        tooltipSettings:
                            InteractiveTooltip(enable: true, color: Colors.red),
                      ),
                      series: <ChartSeries<ImsData, int>>[
                        LineSeries<ImsData, int>(
                          dataSource: xydata,
                          xValueMapper: (ImsData imsdata, _) => imsdata.xValue,
                          yValueMapper: (ImsData imsdata, _) => imsdata.yValue,
                          markerSettings: MarkerSettings(
                            isVisible: false,
                            shape: DataMarkerType.circle,
                            borderColor: Colors.red,
                          ),
                          dataLabelSettings: DataLabelSettings(
                            isVisible: false,
                            showCumulativeValues: true,
                          ),
                        ),
                      ],
                    ),
                    //TextInsert(),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              print("hasError");
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  List findPeaks(a, double thresholdMin, double thresholdMax) {
    var N = a.length - 2;
    var ix = [];
    var ax = [];

    if (thresholdMin != null) {
      print("thresholdMin");
      for (var i = 1; i <= N; i++) {
        if (a[i - 1] <= a[i] &&
            a[i] >= a[i + 1] &&
            a[i] >= thresholdMin &&
            a[i] < thresholdMax) {
          ix.add(i.toDouble());
          ax.add(a[i]);
        }
      }
    } else {
      print("thresholdMin = null");
      for (var i = 1; i <= N; i++) {
        if (a[i - 1] <= a[i] && a[i] >= a[i + 1]) {
          ix.add(i.toDouble());
          ax.add(a[i]);
        }
      }
    }
    return [ix, ax];
  }

  Widget TextInsert() {
    return new Positioned(
      child: Text(
        drugData.name + " Detect",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
      ),
    );
  }

  Widget _getchart3() {
    return Container(
      //padding: new EdgeInsets.fromLTRB(50, 500, 50, 30),
      child: Center(
        child: FutureBuilder(
          future: readJson('data/' + drugData.name + '.json'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data.ims.runtimeType);
              var ims = snapshot.data.ims;
              var data = ims.map((x) => int.parse(x)).toList();
              List<int> d = [...data]; //convert dynamic to List<int>
              print('convert type');
              print(d.runtimeType);
              return Container(
                //padding: new EdgeInsets.fromLTRB(50, 300, 50, 30),
                child: new Stack(
                  children: <Widget>[
                    SfSparkLineChart(
                      lastPointColor: Colors.red,
                      color: Colors.white,
                      trackball: SparkChartTrackball(
                          activationMode: SparkChartActivationMode.tap,
                          backgroundColor: Colors.red),
                      marker: SparkChartMarker(
                          displayMode: SparkChartMarkerDisplayMode.high),
                      labelDisplayMode: SparkChartLabelDisplayMode.high,
                      // data: <double>[.data],
                      data: d,
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              print("hasError");
              return Text("${snapshot.error}");
            }
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

      //child: new Image.network(
      // child: new Image.asset(
      //   .picture,
      //   fit: BoxFit.cover,
      //   height: 300.0,
      // ),
      // child: new Image.asset(
      //   "img/keti.jpg",
      //   fit: BoxFit.cover,
      //   height: 300.0,
      // ),
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
              _test_restful1(),
              new Separator(),
              //_getchart3(),
              IMSgraph(drugData.name),
              //_getchart(),
              new Separator(),
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
