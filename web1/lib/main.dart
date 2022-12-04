// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class apptest extends StatefulWidget {
  const apptest({Key? key}) : super(key: key);

  @override
  _apptestState createState() => _apptestState();
}

class _apptestState extends State<apptest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("test"),
        ),
        body: const WebView(
          initialUrl: "http\\google.com",
        ),
      ),
    );
  }
}
