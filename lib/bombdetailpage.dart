//import 'dart:html';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:container_lib/bombdata.dart';
import 'package:container_lib/containerdata.dart';
// import 'package:container_lib/main.dart';
// import 'package:container_lib/text_style.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

// import 'package:fl_chart/fl_chart.dart';

import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';

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
Future<BombData> getbombdata(String comm, id) async {
  print('1. get data');
  final response = await http.get(address + comm + 'id=' + id);
  print(address + comm + 'id=' + id);
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return BombData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
  //return ContainerData.fromJson(jsonDecode(response.body));
}

Future<ContainerData> getContainerdata(String comm, id) async {
  final response = await http.get(address + comm + 'id=' + id);
  if (response.statusCode == 200) {
    return ContainerData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<BombData> postbombdata(
    String comm, String datatypeid, List postData) async {
  //var body = json.encode(data);

  final http.Response response =
      await http.post(Uri.parse(address + comm), body: <String, String>{
    'data_type_id': datatypeid,
    'cas_no': postData[0],
    'chemical_formula': postData[1],
    'density': postData[2],
    'vapor_pressure': postData[3],
    'boiling_poing': postData[4],
    'melting_point': postData[5],
    'shock_sensitivity': postData[6],
    'friction_sensitivity': postData[7],
    'detonation_velocity': postData[8],
    're_factor': postData[9],
    //'Apparence': postData[2],

    // 'SolubilityWater':postData[2],
    // 'SolubleSolvent': postData[2],
    // 'IonizationEnergy':postData[2],
  });

  print('post data ???');
  print(address + comm);
  print(datatypeid);
  print(postData);
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    return BombData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post');
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

  final List<PlatformFile> _files = [];

  void _pickFiles() async {
    List<PlatformFile> uploadedFiles = (await FilePicker.platform.pickFiles(
      allowMultiple: true,
    ))
        ?.files;
    setState(() {
      for (PlatformFile file in uploadedFiles) {
        _files.add(file);
      }
    });
  }

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
//            new DBHomePageBody(),
            //_getchart(),
            //_getchart2(),
            _getToolbar(context),
          ],
        ),
      ),
    );
  }

  Widget _text_keti(String text) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
    );
  }

  Widget _test_restful1() {
    return Container(
      //padding: new EdgeInsets.fromLTRB(50, 500, 50, 30),
      child: Center(
        child: FutureBuilder<BombData>(
          //future: get_data('get_container_data_by_data_type_id?', .id),
          future: getbombdata('get_bomb_data_by_id?', '1'),
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
          future: readJson('data/' + bombdata.name + '.json'),
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
                          text: bombdata.name + ' Detect',
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

  Widget ketitext(String text) {
    return new Positioned(
      child: new Text(
        text,
        style: TextStyle(
            backgroundColor: Colors.lightGreen,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white),
      ),
    );
  }

  Widget renderTextFormField(
      {@required String label,
      @required FormFieldSetter onSaved,
      @required FormFieldValidator validator}) {
    return Column(
      children: [
        SizedBox(
          width: 150,
          height: 50,
          child: TextFormField(
            textAlign: TextAlign.center,
            onSaved: onSaved,
            validator: validator,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: label,
            ),
          ),
        ),
        Container(height: 30)
      ],
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        final TextEditingController _passwd = TextEditingController();
        return AlertDialog(
          title: const Text('Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                //Text('Enter Passwd'),
                TextField(
                  controller: _passwd,
                  decoration: InputDecoration(hintText: 'enter passwd'),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                if (_passwd.text == 'ketiketi') {
                  Navigator.of(context).pop();
                  print(bombdata.id);
                  setState(() {
                    postbombdata('add_bomb_data?', bombdata.id, postData);
                  });

                  //this.setState(() {});

                  //post .....
                } else {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('ERROR'),
                      //content: const Text('AlertDialog description'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget renderButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: Colors.blue, onPrimary: Colors.white),
      onPressed: () async {
        if (this.formKey.currentState.validate()) {
          this.formKey.currentState.save();
          _showMyDialog();
        }
      },
      child: Text(
        'POST!',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  var postData = List<String>.generate(8, (index) => "-");

  Widget renderValues() {
    return Column(
      children: [
        Text('name : ' + postData[0]),
        Text('name : ' + postData[1]),
        Text('name : ' + postData[2]),
        Text('name : ' + postData[3]),
        Text('name : ' + postData[4]),
        //Text('name : ' + postData[5]),
        // Text('name : ' + bombData.casno),
        // Text('email : ' + bombData.chemicalformula),
        // Text('password : ' + bombData.density),
        // Text('address : ' + bombData.vaporpressure),
      ],
    );
  }

  String casno = '';

  final formKey = GlobalKey<FormState>();
  Widget _postFormfield() {
    return Container(
      decoration: new BoxDecoration(color: Colors.white),
      child: Stack(
        children: <Widget>[
          ketitext("Post Data"),
          Column(
            children: <Widget>[
              Container(height: 35.0),
              new Form(
                key: this.formKey,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          renderTextFormField(
                            label: 'CAS No.',
                            onSaved: (val) {
                              setState(() {
                                postData.insert(0, val);
                              });
                              //testclass = bombdata.casno;
                              //bombData.casno = val;
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '이름은 필수사항입니다.';
                              }

                              if (val.length < 2) {
                                return '이름은 두글자 이상 입력 해주셔야합니다.';
                              }

                              return null;
                            },
                          ),
                          renderTextFormField(
                            label: 'Formula',
                            onSaved: (val) {
                              setState(() {
                                postData.insert(1, val);
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '이름은 필수사항입니다.';
                              }

                              if (val.length < 2) {
                                return '이름은 두글자 이상 입력 해주셔야합니다.';
                              }

                              return null;
                            },
                          ),
                          renderTextFormField(
                            label: 'Density',
                            onSaved: (val) {
                              setState(() {
                                postData.insert(2, val);
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '이름은 필수사항입니다.';
                              }

                              if (val.length < 2) {
                                return '이름은 두글자 이상 입력 해주셔야합니다.';
                              }

                              return null;
                            },
                          ),
                          renderTextFormField(
                            label: 'Vapor pressure',
                            onSaved: (val) {
                              setState(() {
                                postData.insert(3, val);
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '이름은 필수사항입니다.';
                              }

                              if (val.length < 2) {
                                return '이름은 두글자 이상 입력 해주셔야합니다.';
                              }

                              return null;
                            },
                          ),
                          renderTextFormField(
                            label: 'Boiling point',
                            onSaved: (val) {
                              setState(() {
                                postData.insert(4, val);
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '이름은 필수사항입니다.';
                              }

                              if (val.length < 2) {
                                return '이름은 두글자 이상 입력 해주셔야합니다.';
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          renderTextFormField(
                            label: 'Melting point',
                            onSaved: (val) {
                              setState(() {
                                postData.insert(5, val);
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '이름은 필수사항입니다.';
                              }

                              if (val.length < 2) {
                                return '이름은 두글자 이상 입력 해주셔야합니다.';
                              }

                              return null;
                            },
                          ),
                          renderTextFormField(
                            label: 'Shocksensitivity',
                            onSaved: (val) {
                              setState(() {
                                postData.insert(6, val);
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '이름은 필수사항입니다.';
                              }

                              if (val.length < 2) {
                                return '이름은 두글자 이상 입력 해주셔야합니다.';
                              }

                              return null;
                            },
                          ),
                          renderTextFormField(
                            label: 'Frictionsensitivity',
                            onSaved: (val) {
                              setState(() {
                                postData.insert(7, val);
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '이름은 필수사항입니다.';
                              }

                              if (val.length < 2) {
                                return '이름은 두글자 이상 입력 해주셔야합니다.';
                              }

                              return null;
                            },
                          ),
                          renderTextFormField(
                            label: 'Detonationvelocity',
                            onSaved: (val) {
                              setState(() {
                                postData.insert(8, val);
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '이름은 필수사항입니다.';
                              }

                              if (val.length < 2) {
                                return '이름은 두글자 이상 입력 해주셔야합니다.';
                              }

                              return null;
                            },
                          ),
                          renderTextFormField(
                            label: 'RE factor',
                            onSaved: (val) {
                              setState(() {
                                setState(() {
                                  postData.insert(9, val);
                                });
                              });
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return '이름은 필수사항입니다.';
                              }

                              if (val.length < 2) {
                                return '이름은 두글자 이상 입력 해주셔야합니다.';
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                      Container(height: 35.0),
                      renderButton(),
                      //Container(height: 35.0),
                      //renderValues(),
                      //Text(bombData.casno),
                      // renderValues(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget uploadIMSdata() {
    return Container(
        child: Stack(
      children: <Widget>[
        ketitext("Upload IMS Data"),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(height: 50),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                ),
                color: Colors.white,
              ),
              width: 350,
              height: 350,
            ),
            Container(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () => _pickFiles(),
                  child: Text("Choose a file"),
                ),
                Container(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Upload"),
                ),
              ],
            )
          ],
        ),
      ],
    ));
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
              new Text(bombdata.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white)),
              new Separator(),
              new Image.asset(bombdata.image),
              new Separator(),
              //new Text(.description, style: Style.commonTextSt),
              new Text(bombdata.description,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white)),
              new Separator(),
              _test_restful1(),
              new Separator(),
              //_getchart3(),
              _getchart(),
              new Separator(),
              _postFormfield(),
              new Separator(),
              uploadIMSdata(),
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

class ImsData {
  ImsData(this.xValue, this.yValue);
  final int xValue;
  final int yValue;
}
