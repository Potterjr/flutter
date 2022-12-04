// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:homework/page2.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyPage1(),
    );
  }
}

class MyPage1 extends StatefulWidget {
  const MyPage1({Key? key}) : super(key: key);

  @override
  _MyPage1State createState() => _MyPage1State();
}

class _MyPage1State extends State<MyPage1> {
  int num = 0;
  String name = "", password = "";
  TextEditingController tname = TextEditingController();
  TextEditingController tpassword = TextEditingController();

  void coutnum() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      num = preferences.getInt("num") ?? 0;
      name = preferences.getString("username") ?? "";
      password = preferences.getString("password") ?? "";
    });
  }

  void initState() {
    super.initState();
    coutnum();
  }

  void _coutnum1() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      num = (preferences.getInt("num") ?? 0) + 1;
      preferences.setInt("num", num);
    });
  }

  void register() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("username", tname.text);
      name = preferences.getString("username") ?? "";
      preferences.setString("password", tpassword.text);
      password = preferences.getString("password") ?? "";
    });
  }

  void login() {
    setState(() {
      if (name == tname.text && password == tpassword.text) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyPage2(
                      password: tpassword.text,
                      username: tname.text,
                    )));
      } else {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Username และ Password ผิด'),
            content: const Text('กรุณาใส่ Username และ Password ใหม่อีกครั้ง'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    });
  }

  void exit() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure?"),
            content: Text("Yes to Confitm"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                  onPressed: () => SystemChannels.platform
                      .invokeMethod("SystemNavigator.pop"),
                  child: const Text("ok"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page1"),
      ),
      body: Column(
        children: [
          Text("$num"),
          TextField(
            obscureText: false,
            controller: tname,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Username",
            ),
          ),
          TextField(
            obscureText: true,
            controller: tpassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Password",
            ),
          ),
          Text(name),
          Text(password),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: register,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue, 
                  ),
                  child: Text("Register")),
              ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, 
                  ),
                  child: Text("Login")),
              ElevatedButton(
                  onPressed: exit,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[900],
                  ),
                  child: Text("Exit")),
            ],
          )
        ],
      ),
    );
  }
}
