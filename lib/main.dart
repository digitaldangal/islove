import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

void main() => runApp(new WeXiaoApp());

class WeXiaoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '微笑',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new HomePage(title: '微笑'),
      routes: {
        "/image": (context) {
//          Navigator.of(context)
          return new ImageCardPage(
            id: "Image",
          );
        }
      },
      onGenerateRoute: (RouteSettings settings) {
        var name = settings.name;
        if (name.startsWith('/image/')) {
          return new MaterialPageRoute(
            builder: (context) =>
            new ImageCardPage(
              id: name.substring('/image/'.length),
            ),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        print('Route not found ${settings.name}');
        return new MaterialPageRoute(
            builder: (context) => new HomePage(),
            settings: new RouteSettings(
              isInitialRoute: true,
            ));
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const double _maxHeaderHeight = 160.0;

  bool _blessed = false;
  double _scrollTopOffset = 0.0;

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
    });
  }

  double _headerHeight() {
    var h = _maxHeaderHeight - _scrollTopOffset;
    return h < 0.0 ? 0.0 : h > _maxHeaderHeight ? _maxHeaderHeight : h;
  }

  @override
  Widget build(BuildContext context) {
    var scrollCtr = new ScrollController(initialScrollOffset: 0.0);
    timeDilation = 1.8;

    var listBody = new ListView.builder(
      controller: scrollCtr,
      primary: false,
      padding: const EdgeInsets.fromLTRB(2.0, 16.0, 2.0, 8.0),
      itemCount: 16,
      itemExtent: 64.0,
      itemBuilder: (BuildContext context, int index) {
        return new Container(
          margin: new EdgeInsets.only(bottom: 8.0),
          child: new FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/image/$index');
              },
              highlightColor: Colors.pink.shade50,
//              child: new Placeholder()),
              child: new Hero(
                tag: "IMG$index",
                child: new Placeholder(),
              )),
        );
      },
    );
    scrollCtr.addListener(() {
      print(scrollCtr.offset);
      _updateOffset(scrollCtr.offset);
    });

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('微笑'),
        bottom: new PreferredSize(
            child: new Placeholder(
              fallbackHeight: _headerHeight(),
            ),
            preferredSize: new Size.fromHeight(_headerHeight())),
        elevation: 6.0,
      ),

      body: listBody,
      floatingActionButton: new FloatingActionButton(
        onPressed: _blessing,
        tooltip: '祝福',
        child: new Icon(_blessed ? Icons.favorite : Icons.favorite_border),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class ImageCardPage extends StatefulWidget {
  ImageCardPage({Key key, this.id}) : super(key: key);

  final String id;

  @override
  _ImageCardPageState createState() => new _ImageCardPageState();
}

class _ImageCardPageState extends State<ImageCardPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop()),
        title: new Text(widget.id),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: new Hero(tag: "IMG" + widget.id, child: new Placeholder()),
          )
        ],
      ),
    );
  }
}

class NoWhereToLookAtPage extends StatelessWidget {
  NoWhereToLookAtPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Text("Not found, soory.");
  }
}

class PhotoHero extends StatelessWidget {
  const PhotoHero({Key key, this.photo, this.onTap, this.width})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;

  Widget build(BuildContext context) {
    return new SizedBox(
      width: width,
      child: new Hero(
        tag: photo,
        child: new Material(
          color: Colors.transparent,
          child: new InkWell(
            onTap: onTap,
            child: new Placeholder(),
          ),
        ),
      ),
    );
  }
}
