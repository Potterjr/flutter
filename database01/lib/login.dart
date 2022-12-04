// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:database_test/user_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final db = user_table.instance;
  final userC = TextEditingController();
  final passC = TextEditingController();
  List<Map> resultU = [];

  @override
  void initState() {

    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DB test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('assets/img1.jpg'),
              width: 150,
            ),
            TextField(
              controller: userC,
              decoration: const InputDecoration(
                  labelText: "Username", icon: Icon(Icons.person)),
            ),
            TextField(
              controller: passC,
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
                      login_check();
                    });
                  },
                  child: const Text("Login")),
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Navigator.pushNamed(context, '/reg');
                    });
                  },
                  child: const Text(
                    "Register",
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  void login_check() async {
    int? users = await db.findUser(userC.text, passC.text);
    if (users != null) {
      saveUser();
      Navigator.popAndPushNamed(context, '/menu');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Error"),
              content: const Text(
                  "User not found.\nPlease check your username or password."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("OK")),
              ],
            );
          });
    }
  }

  void loadUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    SharedPreferences pass = await SharedPreferences.getInstance();
    setState(() {
      if (user.getString('user') != null && pass.getString('pass') != null) {
        Navigator.popAndPushNamed(context, '/menu');
      }
    });
  }

  void saveUser() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    SharedPreferences pass = await SharedPreferences.getInstance();
    setState(() {
      user.setString('user', userC.text);
      pass.setString('pass', passC.text);
    });
  }
}
