// ignore_for_file: unused_import, annotate_overrides, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:niku/niku.dart';
import 'package:niku/namespace.dart' as n;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  build(context) {
    return Scaffold(
      body: Scaffold(
        body: n.Column([
          n.Text("test")
            ..center
            ..h4 = context,
          n.Column([
            n.Button(n.Text("b1"))
              ..onPressed = () {}
              ..apply = CounterStyles.button(Colors.blue.shade700)
              ..bg = Colors.blue.shade50
              ..splash = Colors.blue.shade100,
            n.Button(n.Text("b2"))
              ..onPressed = () {}
              ..apply = CounterStyles.button(Colors.red.shade700)
              ..bg = Colors.red.shade50
              ..splash = Colors.red.shade100,
          ])
            ..gap = 4
            ..freezed,
        ])
          ..center
          ..gap = 16
          ..alignCenter,
      ),
    );
  }
}

class CounterStyles {
  static button(Color color) => n.Button(SizedBox.shrink())
    ..rounded = 4
    ..px = 24
    ..py = 12
    ..fontSize = 18
    ..w500
    ..color = color;
}
