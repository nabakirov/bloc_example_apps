import 'package:bloc_example_apps/pages/infinite_list/page.dart';
import 'package:bloc_example_apps/pages/timer_app/timer_page.dart';

import 'pages/counter_app/counter_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget pages() {
    return PageView(
      children: <Widget>[
        CounterPage(),
        TimerPage(),
        InfiniteScrollPage()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // primaryColor: Color.fromRGBO(109, 234, 255, 1),
        // accentColor: Color.fromRGBO(72, 74, 126, 1),
        brightness: Brightness.light,
      ),
      title: 'BlocExample',
      home: pages(),
    );
  }
}
