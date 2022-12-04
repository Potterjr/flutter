import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Main Menu"),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img1.jpg"),
                  fit: BoxFit.fitWidth)),
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    "Main Menu",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.manage_search,
                      ),
                      onPressed: () {
                        setState(() {
                          Navigator.pushNamed(context, '/data_man');
                        });
                      },
                      label: const Text("Data Manager"),
                      style: const ButtonStyle(
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.exit_to_app),
                      onPressed: () {
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Logout"),
                                  content: const Text("Do you want logout?"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          logout();
                                          Navigator.popAndPushNamed(
                                              context, '/login');
                                        },
                                        child: const Text(
                                          "Yes",
                                          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("No")),
                                  ],
                                );
                              });
                        });
                      },
                      label: const Text("Logout"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                ],
              )),
        ));
  }

  void logout() async {
    SharedPreferences user = await SharedPreferences.getInstance();
    SharedPreferences pass = await SharedPreferences.getInstance();
    setState(() {
      user.clear();
      pass.clear();
    });
  }
}
