// ignore_for_file: camel_case_types

import 'package:database_test/data_table.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Data_manager extends StatefulWidget {
  const Data_manager({Key? key}) : super(key: key);

  @override
  State<Data_manager> createState() => _Data_managerState();
}

class _Data_managerState extends State<Data_manager> {
  List<Map> resultg = [];
  final db = data_table.instance;
  final titleC = TextEditingController();
  final dataC = TextEditingController();
  final passC = TextEditingController();
  String idx = "";
  String title = "";
  String dcontent = "";
  String pass = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _loadData();
      checkUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Data Manager"),
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
                    "Data Manager",
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          dataC.clear();
                          titleC.clear();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Column(
                                    children: [
                                      const Text(
                                        "Insert new data",
                                        style: TextStyle(fontSize: 32),
                                      ),
                                      TextField(
                                        controller: titleC,
                                        decoration: const InputDecoration(
                                            hintText: "Data Title",
                                            icon: Icon(Icons.edit)),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.all(8.0)),
                                      TextField(
                                        maxLines: 3,
                                        controller: dataC,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: "Data Content",
                                            icon: Icon(Icons.edit)),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          _insert();
                                          _loadData();
                                          Navigator.pop(context);
                                        },
                                        child: const Text("OK",
                                            style: TextStyle(
                                                color: Colors.green))),
                                    TextButton(
                                        onPressed: () {
                                          titleC.clear();
                                          dataC.clear();
                                        },
                                        child: const Text("Clear",
                                            style: TextStyle(
                                                color: Colors.orange))),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel",
                                            style:
                                                TextStyle(color: Colors.red))),
                                  ],
                                );
                              });
                        });
                      },
                      label: const Text(
                        "Insert data",
                        textAlign: TextAlign.center,
                      ),
                      style: const ButtonStyle(
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                  Text("Selected Data : " + title),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          if (idx.isEmpty) {
                            idxEmpty();
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Column(
                                      children: [
                                        const Text(
                                          "Display data",
                                          style: TextStyle(fontSize: 32),
                                        ),
                                        TextField(
                                          readOnly: true,
                                          controller: titleC,
                                          decoration: const InputDecoration(
                                              hintText: "Data Title",
                                              icon: Icon(Icons.edit)),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.all(8.0)),
                                        TextField(
                                          readOnly: true,
                                          maxLines: 3,
                                          controller: dataC,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: "Data Content",
                                              icon: Icon(Icons.edit)),
                                        )
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("OK")),
                                    ],
                                  );
                                });
                            titleC.text = title;
                            dataC.text = dcontent;
                          }
                        });
                      },
                      label: const Text("Display data"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          if (idx.isEmpty) {
                            idxEmpty();
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Delete data"),
                                    content: const Text(
                                        "Do you really want to delete this data?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            _delete();
                                            _loadData();
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Yes",
                                            style: TextStyle(color: Colors.red),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No")),
                                    ],
                                  );
                                });
                          }
                        });
                      },
                      label: const Text("Delete data"),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        setState(() {
                          if (idx.isEmpty) {
                            idxEmpty();
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Password Required"),
                                    content: TextField(
                                      controller: passC,
                                      decoration: const InputDecoration(
                                        labelText: "Password",
                                        icon: Icon(Icons.vpn_key),
                                      ),
                                      obscureText: true,
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            if (passC.text == pass) {
                                              Navigator.pop(context);
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Edit data"),
                                                      content: const Text(
                                                          "Do you want to edit this data?"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      content:
                                                                          Column(
                                                                        children: [
                                                                          const Text(
                                                                            "Display data",
                                                                            style:
                                                                                TextStyle(fontSize: 32),
                                                                          ),
                                                                          TextField(
                                                                            controller:
                                                                                titleC,
                                                                            decoration:
                                                                                const InputDecoration(hintText: "Data Title", icon: Icon(Icons.edit)),
                                                                          ),
                                                                          const Padding(
                                                                              padding: EdgeInsets.all(8.0)),
                                                                          TextField(
                                                                            maxLines:
                                                                                3,
                                                                            controller:
                                                                                dataC,
                                                                            decoration: const InputDecoration(
                                                                                border: OutlineInputBorder(),
                                                                                hintText: "Data Content",
                                                                                icon: Icon(Icons.edit)),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      actions: [
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              _update();
                                                                              _loadData();
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                const Text("OK")),
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              titleC.text = title;
                                                                              dataC.text = dcontent;
                                                                            },
                                                                            child:
                                                                                const Text("Resest")),
                                                                        TextButton(
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                const Text("Cancel")),
                                                                      ],
                                                                    );
                                                                  });
                                                            },
                                                            child: const Text(
                                                              "Yes",
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "No")),
                                                      ],
                                                    );
                                                  });
                                            } else {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title:
                                                          const Text("Error"),
                                                      content: const Text(
                                                          "Invalid password"),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                                "OK")),
                                                      ],
                                                    );
                                                  });
                                            }
                                          },
                                          child: const Text(
                                            "OK",
                                          )),
                                    ],
                                  );
                                });

                            titleC.text = title;
                            dataC.text = dcontent;
                          }
                        });
                      },
                      label: const Text("Edit data"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange),
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                    child: showList(),
                  ))
                ],
              )),
        ));
  }

  void _insert() async {
    Map<String, dynamic> row = {
      data_table.columnTitle: titleC.text,
      data_table.columnData: dataC.text,
    };
    final ID = await db.insert(row);
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Insert"),
              content: const Text("New data inserted"),
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

  void _update() async {
    Map<String, dynamic> row = {
      data_table.columnId: int.parse(idx),
      data_table.columnTitle: titleC.text,
      data_table.columnData: dataC.text,
    };
    final ID = await db.update(row);
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Update"),
              content: const Text("Data updated"),
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

  void _delete() async {
    int id = int.parse(idx);
    final ID = await db.delete(id);
    setState(() {
      title = "";
      idx = "";
    });
  }

  void _loadData() async {
    Database db = await data_table.instance.database;
    List<Map> mylist = await db.query(data_table.table);
    setState(() {
      resultg = mylist;
    });
  }

  void idxEmpty() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("No data seleted"),
            content: const Text("Please select data"),
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

  Widget showList() {
    return Column(
      children: resultg
          .map((lists) => Card(
                child: ListTile(
                  onTap: () {
                    setState(() {
                      idx = lists["data_id"].toString();
                      title = lists["data_title"].toString();
                      dcontent = lists["data_content"].toString();
                    });
                  },
                  title: Text(
                    lists["data_title"].toString(),
                    style: const TextStyle(fontSize: 24),
                  ),
                  //leading: Text(lists["name"].toString()),
                  subtitle: Text(lists["data_content"].toString()),
                ),
              ))
          .toList(),
    );
  }

  checkUser() async {
    SharedPreferences passs = await SharedPreferences.getInstance();
    pass = passs.getString('pass')!;
  }
}
