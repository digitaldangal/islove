import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islove/styles.dart';

class SlidePage extends StatefulWidget {
  @override
  _SlidePageState createState() {
    return _SlidePageState();
  }
}

const _slidesAssets = <String>[
  'assets/slides/1.png',
  'assets/slides/2.png',
  'assets/slides/3.png',
];

class _SlidePageState extends State<SlidePage> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Preload images
    var localImageConfiguration = createLocalImageConfiguration(context);
    new AssetImage('assets/slides/2.png').resolve(localImageConfiguration);
    new AssetImage('assets/slides/3.png').resolve(localImageConfiguration);
    return Container(
      child: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          Image.asset(
            'assets/slides/1.png',
            fit: BoxFit.cover,
            gaplessPlayback: true,
          ),
          Image.asset(
            'assets/slides/2.png',
            fit: BoxFit.cover,
            gaplessPlayback: true,
          ),
          Container(
            constraints: new BoxConstraints.expand(
              height: 200.0,
            ),
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 24.0),
            child: new FlatButton(
              onPressed: () {
                // Restore default
                SystemChrome.setPreferredOrientations([]);
                Navigator.of(context).pushReplacementNamed('/home');
              },
              child: const Text(
                "是爱",
                style: const TextStyle(color: Colors.white),
              ),
              color: Styles.bannerColor,
            ),
            decoration: new BoxDecoration(
                image: new DecorationImage(
              image: const AssetImage('assets/slides/3.png'),
              fit: BoxFit.cover,
            )),
          )
        ],
      ),
//      child: GestureDetector(
//          onTap: () => print("Do Tap"),
//          child: ListView(
//            scrollDirection: Axis.horizontal,
//            children: <Widget>[
//              Image.asset('assets/slides/1.png'),
//              Image.asset('assets/slides/2.png'),
//              Image.asset('assets/slides/3.png')
//            ],
//          )
//      ),
    );
  }
}
