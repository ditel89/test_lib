import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:container_lib/bombdata.dart';
import 'package:container_lib/text_style.dart';
import 'package:container_lib/bombdetailpage.dart';

class BombHomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return new bombdataRow(bombdatas[0]);
    return new Expanded(
      child: new ListView.builder(
        itemBuilder: (context, index) => new BombRow(bombDatas[index]),
        itemCount: bombDatas.length,
        padding: new EdgeInsets.symmetric(vertical: 10.0),
      ),
    );
  }
}

class BombRow extends StatelessWidget {
  final BombData bombdata;
  final bool horizontal;

  BombRow(this.bombdata, {this.horizontal = true});

  BombRow.vertical(this.bombdata) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    final bombdataThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      //alignment: FractionalOffset.centerLeft,
      alignment:
          horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
        tag: "bombdata-hero-${bombdata.id}",
        child: new Image(
          image: new AssetImage(bombdata.image),
          height: 92.0,
          width: 92.0,
        ),
      ),
    );

    final bombdataCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(
          horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(
            bombdata.name,
            style: Style.titleTextSt,
          ),
          new Container(height: 10.0),
          new Text(
            bombdata.casno,
            style: Style.commonTextSt,
          ),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 18.0,
            color: new Color(0xff00c6ff),
          ),
        ],
      ),
    );

    final bombdataCard = new Container(
      child: bombdataCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
          //? new EdgeInsets.only(left: 46.0)
          ? new EdgeInsets.only(left: 46.0)
          : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          )
        ],
      ),
    );

    return new GestureDetector(
      onTap: horizontal
          ? () => Navigator.of(context).push(
                new PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new BombDetailPage(bombdata),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          new FadeTransition(opacity: animation, child: child),
                ),
              )
          : null,
      child: new Container(
        height: 120.0,
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            bombdataCard,
            bombdataThumbnail,
          ],
        ),
      ),
    );
  }
}
