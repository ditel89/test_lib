import 'dart:convert';

import 'package:container_lib/bombdetailpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:container_lib/bombdata.dart';
import 'package:http/http.dart' as http;

// class POSTData extends State<BombDetailPage> {

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
    'boiling_point': postData[4],
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
  // print(address + comm);
  // print(datatypeid);
  print(postData);
  print(response.body);
  print(response.statusCode);
  if (response.statusCode == 200) {
    return BombData.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to post');
  }
}

class PostFormfield extends StatefulWidget {
  final dataID;
  PostFormfield(this.dataID);
  @override
  PostFormfieldState createState() => PostFormfieldState(dataID);
}

class PostFormfieldState extends State<PostFormfield> {
  final dataID;
  PostFormfieldState(this.dataID);

  final formKey = GlobalKey<FormState>();
  var postData = List<String>.generate(8, (index) => "-");

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Stack(
        children: <Widget>[
          postformfild(),
        ],
      ),
    );
  }

  Widget postformfild() {
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
                            },
                            validator: (val) {
                              if (val.length < 1) {
                                return 'essential.';
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
                                return 'essential.';
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
                                return 'essential.';
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
                                return 'essential.';
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
                                return 'essential.';
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
                                return 'essential.';
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
                                return 'essential.';
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
                                return 'essential.';
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
                                return 'essential.';
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
                                return 'essential.';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                      Container(height: 35.0),
                      renderButton(),
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
                  obscureText: true,
                  //textInputAction: TextInputAction.go,
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
                  print(dataID);
                  setState(() {
                    postbombdata('add_bomb_data?', dataID, postData);
                  });
                  postData.clear();
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
}
