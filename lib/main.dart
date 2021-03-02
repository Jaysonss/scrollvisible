import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ScrollVisible(),
    );
  }
}

class ScrollVisible extends StatefulWidget {
  @override
  _ScrollVisibleState createState() => _ScrollVisibleState();
}

class _ScrollVisibleState extends State<ScrollVisible> {
  GlobalKey _visibleKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Visible Demo"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  color: Colors.blue,
                ),
                Container(
                  height: 300,
                  color: Colors.yellow,
                ),
                Container(
                  key: _visibleKey,
                  height: 150,
                  color: Colors.white,
                  child: Center(
                    child: Text("Visible测试组件"),
                  ),
                ),
                Container(
                  height: 600,
                  color: Colors.red,
                ),
              ],
            ),
          ),
          Positioned(
            right: 200,
            bottom: 200,
            child: FloatingActionButton(
              child: Text("使组件可见"),
              onPressed: _makeVisible,
            ),
          ),
        ],
      ),
    );
  }

  void _makeVisible() {
    Scrollable.ensureVisible(_visibleKey.currentContext);
  }
}
