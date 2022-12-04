// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import, prefer_const_constructors, deprecated_member_use, prefer_typing_uninitialized_variables
import 'package:navigator/navigator.dart';
import 'package:flutter/material.dart';

import 'SecondScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'test'),
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
  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              controller: text1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'text1',
              ),
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              controller: text2,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          ElevatedButton(
            child: Text(
              'Go to second screen',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              _sendDataToSecondScreen(context);
            },
          )
        ],
      ),
    );
  }

  void _sendDataToSecondScreen(BuildContext context) {
    String textToSend1 = text1.text;
    String textToSend2 = text2.text;
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondScreen(
            textsec1: textToSend1,
            textsec2: textToSend2, 
          ),
        ));
  }
}
