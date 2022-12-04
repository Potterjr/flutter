// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, prefer_typing_uninitialized_variables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

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
  @override
  Widget build(BuildContext context) {
    final controller = GroupButtonController();
    List<String> list1 = ['1', '2', '3', '4'];
    List<String> list2 = ['10', '50', '100', '150'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("quiz"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("โจทย์", style: TextStyle(fontSize: 30)),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: [
                  Text("ข้อ1", style: TextStyle(fontSize: 30)),
                  GroupButton(
                    isRadio: true,
                    spacing: 20,
                    onSelected: (index, isSelected) =>
                        print('$index button is selected'),
                    controller: controller,
                    buttons: [
                      list1[0],
                      list1[1],
                      list1[2],
                      list1[3],
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Text("ข้อ2", style: TextStyle(fontSize: 30)),
                  GroupButton(
                    isRadio: true,
                    spacing: 20,
                    onSelected: (index, isSelected) =>
                        print('$index button is selected'),
                    controller: controller,
                    buttons: [
                      list2[0],
                      list2[1],
                      list2[2],
                      list2[3],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
