import 'package:flutter/material.dart';

import 'package:quiz_hw/qmenu.dart';
import 'package:quiz_hw/stat.dart';

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
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/menu': (context) => MyHomePage(),
        'qmenu': (context) => const qmenu(),
        'stat': (context) => const stat(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> menustr = ['Quiz', 'Statistic'];
  List<String> menurot = ['qmenu', 'stat' ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const Text("Main menu", style: TextStyle(fontSize: 35)),
            Expanded(
              child: ListView.builder(
                  itemCount: menustr.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(menustr[index]),
                      onTap: () => Navigator.pushNamed(context, menurot[index]),
                    );
                  }),
            ),
          ]),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
