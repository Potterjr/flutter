// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();
  var answer = '';
  var t = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              controller: text1,
              decoration: InputDecoration(
                labelText: 'height in cm',
                icon: Icon(Icons.height),
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
              decoration: InputDecoration(
                labelText: 'weight  in cm',
                icon: Icon(Icons.person),
              ),
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          ElevatedButton(
            child: Text(
              'calculate BMI',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              cal();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text("BMI Result"),
     
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text(answer)
          ),
           Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text(t)
          ),
        ],
      ),
    );
  }

  cal() {
    setState(() {
      double height = double.parse(text1.text) / 100;
      double kg = double.parse(text2.text);
      double h = height * height;
      double ans = kg / h;

      if (ans > 30) {
        answer = ans.toString();
        t="อ้วนมาก";
      } else if (ans <= 29.99 && ans >= 25) {
        answer = ans.toString();
         t="อ้วน";
      }
       else if (ans <= 24.99 && ans >= 23) {
        answer = ans.toString();
         t="น้ำหนักเกิน";
      }
      else if (ans <= 22.99 && ans >= 18.50) {
        answer = ans.toString();
         t="น้ำหนักปกติ";
      }
      else if (ans < 18.49) {
        answer = ans.toString();
         t="ผอม";
      }
      else{
          answer = "error";
      }
    });
  }
}
