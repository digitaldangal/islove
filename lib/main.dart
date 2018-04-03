import 'package:flutter/material.dart';
import 'package:islove/pages/flash.dart';
import 'package:islove/pages/home.dart';
import 'package:islove/pages/slide.dart';

void main() {
  runApp(new WeXiaoApp());
}

class WeXiaoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '是爱',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
//      home: new HomePage(title: '是爱'),
      home: SlidePage(),
      routes: {
        "/home": (context) => HomePage(),
        "/image": (context) {
//          Navigator.of(context)
          return new FlashPage(
            id: "Image",
          );
        }
      },
      onGenerateRoute: (RouteSettings settings) {
        var name = settings.name;
        if (name.startsWith('/image/')) {
          return new MaterialPageRoute(
            builder: (context) => new FlashPage(
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

class NoWhereToLookAtPage extends StatelessWidget {
  NoWhereToLookAtPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Text("Not found, soory.");
  }
}
