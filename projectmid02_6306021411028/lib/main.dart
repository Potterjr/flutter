// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import, prefer_const_constructors, deprecated_member_use, prefer_typing_uninitialized_variables
import 'package:flutter/services.dart';
import 'package:navigator/navigator.dart';
import 'package:flutter/material.dart';

import 'imgpic.dart';
import 'qrscan.dart';

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
          scaffoldBackgroundColor: Color.fromARGB(255, 67, 198, 216)),
      home: const MyHomePage(title: 'Page navigator'),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Text(
            "Main menu",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              minimumSize: const Size.fromHeight(30),
            ),
            child: Text(
              'QR Scan',
              style: TextStyle(fontSize: 40),
            ),

            
            onPressed: () {
              qr(context);
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.purple,
              minimumSize: const Size.fromHeight(30),
            ),
            child: Text(
              'Image Picker',
              style: TextStyle(fontSize: 40),
            ),
            onPressed: () {
              imgpics(context);
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromARGB(255, 255, 0, 0),
              minimumSize: const Size.fromHeight(30),
            ),
            child: Text(
              'exit',
              style: TextStyle(fontSize: 40),
            ),
            onPressed: () {
              SystemNavigator.pop();
            },
          )
        ],
      ),
    );
  }

  void qr(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => qrscan(),
        ));
  }

  void imgpics(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraWidget(),
        ));
  }
  
}
