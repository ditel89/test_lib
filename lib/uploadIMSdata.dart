import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UploadIMSdata extends StatefulWidget {
  final dataID;
  UploadIMSdata(this.dataID);
  uploadIMSdataState createState() => uploadIMSdataState(dataID);
}

class uploadIMSdataState extends State<UploadIMSdata> {
  final dataID;
  uploadIMSdataState(this.dataID);
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Stack(
        children: <Widget>[
          uploadIMSdata(),
        ],
      ),
    );
  }

  final List<PlatformFile> _files = [];
  void _pickFiles() async {
    List<PlatformFile> uploadedFiles = (await FilePicker.platform.pickFiles(
      allowMultiple: false,
    ))
        ?.files;
    setState(() {
      for (PlatformFile file in uploadedFiles) {
        _files.add(file);
      }
    });
  }

  postIMSdata() async {
    if (_files.first != null) {
      print("start post ims data");
      var fileBytes = _files.first.bytes;
      var fileName = _files.first.name;
      var url = 'http://123.214.186.168:3810/add_ims_data_file';

      var dio = Dio();

      var formData = FormData.fromMap({
        'data_type_id': dataID,
        'file': await MultipartFile.fromBytes(fileBytes, filename: fileName)
      });

      final response = await dio.post(
        url,
        data: formData,
      );
      print("response.statusCode");
      if (response.statusCode == 200) {
        _files.removeAt(0);
        _files.clear();
      }
    } else {
      throw "Cancelled upload";
    }
  }

  _onLoadingProgress(BuildContext context) {
    Future checkCondition() {
      return Future.delayed(new Duration(milliseconds: 200), () {
        if (_files.length != 0) {
          checkCondition();
        } else {
          Navigator.of(context).pop();
        }
      });
    }

    new Future.delayed(new Duration(seconds: 1), () {
      checkCondition();
    });

    return SpinKitWave(color: Colors.green, type: SpinKitWaveType.start);
    // return SpinKitPianoWave(
    //   size: 100,
    //   itemBuilder: (BuildContext context, int index) {
    //     return DecoratedBox(
    //       decoration: BoxDecoration(
    //         color: index.isEven ? Colors.red : Colors.green,
    //       ),
    //     );
    //   },
    // );
  }

  Widget uploadIMSdata() {
    return Container(
      child: Stack(
        children: <Widget>[
          ketitext("Upload IMS Data"),
          Container(height: 100),
          Row(
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
                width: 400,
                height: 50,
                //child: Text("Choose a file"),
                child: ListView.builder(
                  itemCount: _files.isEmpty ? 1 : _files.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _files.isEmpty
                        ? const ListTile(title: Text("upload IMS json file"))
                        : ListTile(
                            title: Text(_files.elementAt(index).name),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(
                                  () {
                                    _files.removeAt(index);
                                  },
                                );
                              },
                            ),
                          );
                  },
                ),
              ),
              Container(width: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _pickFiles(),
                    child: Text("Choose a file"),
                  ),
                  Container(width: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_files.isNotEmpty) {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              postIMSdata();
                              return _onLoadingProgress(context);
                            });
                      } else {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('ERROR no file'),
                            //content: const Text('AlertDialog description'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text("Upload"),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
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
}
