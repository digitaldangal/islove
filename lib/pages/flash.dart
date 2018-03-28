import 'package:flutter/material.dart';
import 'package:islove/api/apiv1.dart';

class FlashPage extends StatefulWidget {
  FlashPage({Key key, this.id}) : super(key: key);

  final String id;

  @override
  _FlashPageState createState() => new _FlashPageState();
}

class _FlashPageState extends State<FlashPage> {
  bool _loading = true;
  DataV1 _data;
  FlashV1 _flash = new FlashV1("加载中", "奋力加载中", "");

  @override
  void initState() {
    super.initState();

    var api = ApiV1.get();
    _data = api.getDataNow();
    if (_data != null) {
      _loading = false;
      _flash = _data.flashes[int.parse(widget.id)];
    } else {
      api.getData().then((data) {
        setState(() {
          _loading = false;
          _data = data;
          _flash = _data.flashes[int.parse(widget.id)];
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_loading) {
      body = new Text("奋力加载中");
    } else {
      body = new ListView(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: new Material(
              elevation: 3.0,
              child: new Hero(
                tag: "Flash#" + widget.id,
                child: new Image(
                  image: new NetworkImage(
                    _flash.image,
                  ),
                  fit: BoxFit.cover,
//          alignment: const Alignment(100.0, -1.0),
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
          new Material(
            elevation: 1.0,
            child: new Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.only(bottom: 12.0),
              child: new Center(
                child: new Text(_flash.description, style: new TextStyle(fontSize: 16.0)),
              ),
            ),
          ),
        ],
      );
    }
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(icon: new Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: new Text(_flash.title),
      ),
      body: body,
    );
  }
}
