import 'package:flutter/material.dart';


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
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new TabBarView(
        controller: _tabController,
        children: <Widget>[
          Image.asset('assets/slides/1.png', fit: BoxFit.cover,),
          Image.asset('assets/slides/2.png', fit: BoxFit.cover,),
          Container(
            constraints: new BoxConstraints.expand(
              height: 200.0,
            ),
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(bottom: 52.0),
            child: new FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/home');
              },
              child: const Text(""),
            ),
            decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: const AssetImage('assets/slides/3.png'),
                  fit: BoxFit.cover,
                )
            ),
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
