// ignore_for_file: prefer_const_constructors, unused_field, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'classStore.dart';

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
  var show;
  var data = TextEditingController();
  var store = classstore();
  
  void saveFile() {
    store.writefile(data.toString());
   
  }

  void readfile() {
    store.readFile().then((String value) {
      setState(() {
      show+= value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("save and read"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Text(
             "$show",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: data,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'data',
                    hintText: 'Enter data'),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: 250,

              decoration: BoxDecoration(
                  color: Colors.pink, borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  saveFile();
                },
                child: Text(
                  'savefile',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  readfile();
                },
                child: Text(
                  'readfile',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
