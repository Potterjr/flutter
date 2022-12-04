// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:database_test/user_table.dart';
import 'package:sqflite/sqflite.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final db = user_table.instance;
  final user = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img1.jpg"),
                fit: BoxFit.fitWidth)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: user,
                decoration: const InputDecoration(
                    labelText: "Username", icon: Icon(Icons.person)),
              ),
              TextField(
                controller: password,
                decoration: const InputDecoration(
                  labelText: "Password",
                  icon: Icon(Icons.vpn_key),
                ),
                obscureText: true,
              ),
              const Padding(padding: EdgeInsets.all(15.0)),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _insert();
                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      "Register",
                      //style: TextStyle(color: (Colors.black)),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _insert() async {
    Map<String, dynamic> row = {
      user_table.columnUser: user.text,
      user_table.columnPass: password.text,
    };
    final ID = await db.insert(row);
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Register"),
              content: const Text("New user registered"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK")),
              ],
            );
          });
    });
  }
}
