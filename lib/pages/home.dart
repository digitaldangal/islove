import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:islove/api/apiv1.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title = "是爱"}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double _maxHeaderHeight = 200.0;

  bool _blessed = false;
  double _scrollTopOffset = 0.0;
  bool _loading = true;
  DataV1 _data;
  String _error;
  double _hHeight = _maxHeaderHeight;

  @override
  initState() {
    super.initState();
    print("Loading data");
    _load();
  }

  void _load() {
    ApiV1.get().getData().then((data) {
      print("Title ${data.title} v${data.version}");
      setState(() {
        _loading = false;
        _data = data;
      });
    }).catchError((err) {
      setState(() {
        _error = err.toString();
      });
    });
  }

  void _blessing() {
    setState(() {
      _blessed = true;
    });
  }

  void _reset() {
    setState(() {
      _blessed = false;
    });
  }

  void _updateOffset(double offset) {
    setState(() {
      _scrollTopOffset = offset;
      _hHeight = _headerHeight();
    });
  }

  void _reload() {
    setState(() {
      _loading = true;
      _error = null;
    });
  }

  double _headerHeight() {
    var h = _maxHeaderHeight - _scrollTopOffset;
    return h < 0.0 ? 0.0 : h > _maxHeaderHeight ? _maxHeaderHeight : h;
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_error != null) {
      body = new Center(
          child: new Column(
        children: <Widget>[
          new Text(_error),
          new FlatButton.icon(
            icon: new Icon(Icons.refresh),
            label: new Text("点击刷新"),
            onPressed: _reload,
          )
        ],
      ));
    } else if (_loading) {
      body = new Center(
        child: new Text("奋力加载中..."),
      );
    } else {
      var scrollCtr = new ScrollController(initialScrollOffset: 0.0);

      body = new ListView.builder(
        controller: scrollCtr,
        primary: false,
        padding: const EdgeInsets.fromLTRB(2.0, 16.0, 2.0, 8.0),
        itemCount: _data.flashes.length,
        itemExtent: 128.0,
        itemBuilder: (BuildContext context, int index) {
          return new Container(
              margin: const EdgeInsets.only(bottom: 16.0),
              child: new Material(
                elevation: 4.0,
                child: new GestureDetector(
                  onTap: () {
                    timeDilation = 1.4;
                    Navigator.of(context).pushNamed('/image/$index');
                  },
                  child: new Hero(
                    tag: "Flash#${index}",
                    child: new Image(
                      image: new NetworkImage(
                        _data.flashes[index].image,
                      ),
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ));
        },
      );
      scrollCtr.addListener(() {
        _updateOffset(scrollCtr.offset);
      });
    }

    return new Scaffold(
      appBar:
          //  new PreferredSize(
          //   child: new Material(
          //automaticallyImplyLeading: false,
//        title: new Container(),
//        title: new Text(widget.title),
          // child:
          new PreferredSize(
        child: new Material(
          //rgb(254, 98, 89)
          color: const Color.fromARGB(255, 254, 98, 89), // 匹配 banner 色
          elevation: 6.0,
          child: new SafeArea(
            top: true,
            child: new Container(
              height: _hHeight,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage(
                    "assets/banner/banner.png",
                  ),
                  fit: BoxFit.cover,
//                alignment: Alignment.topCenter,
                ),
              ),
            ),
          ),
        ),
        preferredSize: new Size.fromHeight(_hHeight),
      ),
      //   ),
      // ),
      body: body,
      floatingActionButton: new FloatingActionButton(
        onPressed: _blessing,
        tooltip: '祝福',
        child: new Icon(_blessed ? Icons.favorite : Icons.favorite_border),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
