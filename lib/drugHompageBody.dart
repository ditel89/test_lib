import 'package:flutter/material.dart';
import 'package:container_lib/drugdata.dart';
import 'package:container_lib/text_style.dart';
import 'package:container_lib/drugdetailpage.dart';

class DrugHomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return new drugdataRow(drugdatas[0]);
    return new Expanded(
      child: new ListView.builder(
          itemBuilder: (context, index) => new DrugRow(drugdatas[index]),
          itemCount: drugdatas.length,
          padding: new EdgeInsets.symmetric(vertical: 10.0)),
    );
  }
}

class DrugRow extends StatelessWidget {
  final DrugData drugdata;
  final bool horizontal;

  DrugRow(this.drugdata, {this.horizontal = true});

  DrugRow.vertical(this.drugdata) : horizontal = false;

  @override
  Widget build(BuildContext context) {
    final drugdataThumbnail = new Container(
      margin: new EdgeInsets.symmetric(vertical: 16.0),
      //alignment: FractionalOffset.centerLeft,
      alignment:
          horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
        tag: "drugdata-hero-${drugdata.id}",
        child: new Image(
          image: new AssetImage(drugdata.image),
          height: 92.0,
          width: 92.0,
        ),
      ),
    );

    Widget _drugdataValue({String value, String image}) {
      return new Container(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Image.asset(image, height: 12.0),
            new Container(width: 8.0),
            new Text(value, style: Style.smallTextSt),
          ],
        ),
      );
    }

    final drugdataCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(
          horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment:
            horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(
            drugdata.name,
            style: Style.titleTextSt,
          ),
          new Container(height: 10.0),
          new Text(
            drugdata.location,
            style: Style.commonTextSt,
          ),
          new Container(
            margin: new EdgeInsets.symmetric(vertical: 8.0),
            height: 2.0,
            width: 18.0,
            color: new Color(0xff00c6ff),
          ),
          new Row(
            children: <Widget>[
              new Expanded(
                flex: horizontal ? 1 : 0,
                child: _drugdataValue(
                    value: drugdata.distance, image: 'img/ic_distance.png'),
              ),
              new Container(
                width: 32.0,
              ),
              new Expanded(
                flex: horizontal ? 1 : 0,
                child: _drugdataValue(
                    value: drugdata.gravity, image: 'img/ic_gravity.png'),
              ),
            ],
          )
        ],
      ),
    );

    final drugdataCard = new Container(
      child: drugdataCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
          ? new EdgeInsets.only(left: 46.0)
          : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
        // color: new Color(0xFF333366),
        color: new Color(0xFF336659),
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
                    pageBuilder: (_, __, ___) => new DrugDetailPage(drugdata),
                    transitionsBuilder: (context, animation, secondaryAnimation,
                            child) =>
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
              drugdataCard,
              drugdataThumbnail,
            ],
          ),
        ));
  }
}
