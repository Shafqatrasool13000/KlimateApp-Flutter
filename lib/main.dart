import 'package:flutter/material.dart';
import 'package:klimeticapp/ui/Kinmetics.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Climatic());
  }
}

class Screen1 extends StatefulWidget {
  final String secondScreen;
  Screen1({this.secondScreen});
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  Future _getPage2(BuildContext context) async {
    Map result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Screen2(
            name: _controller.text,
          );
        },
      ),
    );
    _controller.text = result['intro'];
  }

  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: TextField(
              controller: _controller,
            ),
          ),
          RaisedButton(
              child: Text('push to Next Screen'),
              onPressed: () {
                _getPage2(context);
              }),
        ],
      ),
    );
  }
}

class Screen2 extends StatefulWidget {
  final String name;
  Screen2({this.name});
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  TextEditingController _screen2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Screen1(
      secondScreen: _screen2.text,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen 2'),
      ),
      body: ListView(
        children: <Widget>[
          Text(
            '${widget.name}',
            textAlign: TextAlign.center,
          ),
          ListTile(
            title: TextField(
              controller: _screen2,
            ),
          ),
          FlatButton(
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context, {
                  'intro': _screen2.text,
                });
              },
              child: Text('Push to Move back')),
        ],
      ),
    );
  }
}
