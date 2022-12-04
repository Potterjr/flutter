import 'package:flutter/material.dart';

class MyPage2 extends StatefulWidget {
  final String username, password;
  const MyPage2({Key? key, required this.username, required this.password})
      : super(key: key);

  @override
  _MyPage2State createState() => _MyPage2State();
}

class _MyPage2State extends State<MyPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page2"),
      ),
      body: Column(
        children: [
          Text(widget.username),
          Text(widget.password),
        ],
      ),
    );
  }
}
