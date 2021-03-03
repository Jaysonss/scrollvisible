import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
                  height: 1000,
                  color: Colors.white,
                ),
                Container(
                  key: _visibleKey,
                  height: 400,
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      "Visible测试组件",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  height: 1000,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          Positioned(
            right: 50,
            bottom: 50,
            child: FloatingActionButton(
              child: Center(
                child: Text("Make It Visible"),
              ),
              onPressed: _makeVisible,
            ),
          ),
        ],
      ),
    );
  }

  void _makeVisible() {
    var object = _visibleKey.currentContext.findRenderObject();
    var position = Scrollable.of(_visibleKey.currentContext).position;
    final RenderAbstractViewport viewport = RenderAbstractViewport.of(object);
    double max = viewport
        .getOffsetToReveal(object, 0.0)
        .offset
        .clamp(position.minScrollExtent, position.maxScrollExtent) as double;
    double min = viewport
        .getOffsetToReveal(object, 1.0)
        .offset
        .clamp(position.minScrollExtent, position.maxScrollExtent) as double;
    if (position.pixels >= min && position.pixels <= max) {
      Scaffold.of(_visibleKey.currentContext)
          .showSnackBar(SnackBar(content: Text("无需滚动")));
      return;
    }
    position.jumpTo(position.pixels.clamp(min, max));
  }
}
