import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Ims {
  //final String id;
  final List ims;

  Ims({
    this.ims,
  });

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

class ImsData {
  ImsData(this.xValue, this.yValue);
  final int xValue;
  final int yValue;
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

class IMSgraph extends StatelessWidget {
  final filename;
  IMSgraph(this.filename);

  Widget build(BuildContext context) {
    return Container(
      //padding: new EdgeInsets.fromLTRB(50, 500, 50, 30),
      child: Center(
        child: FutureBuilder(
          future: readJson('data/' + filename + '.json'),
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
                          text: filename + ' Detect',
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
}
