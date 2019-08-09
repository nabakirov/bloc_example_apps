import 'pages/counter_app/counter_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget pages() {
    return PageView(
      children: <Widget>[
        CounterPage(),
        Container(
            color: Colors.green,
            alignment: AlignmentDirectional.center,
            child: Text('hello',
                style: TextStyle(fontSize: 132.0, color: Colors.white))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlocExample',
      home: pages(),
    );
  }
}
