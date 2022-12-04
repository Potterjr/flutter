import 'package:flutter/material.dart';
import 'package:quiz_hw/quiz.dart';

class qmenu extends StatefulWidget {
  const qmenu({Key? key}) : super(key: key);

  @override
  State<qmenu> createState() => _qmenuState();
}

class _qmenuState extends State<qmenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Quiz select"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const Text("Please select a quiz", style: TextStyle(fontSize: 35)),
            Expanded(
              child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text("Quiz #" + (index + 1).toString()),
                        onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => quiz(
                                      index: index.toString(),
                                      title:
                                          "Quiz #" + (index + 1).toString())),
                            ));
                  }),
            ),
          ]),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class args {
  final int index;
  final String title;

  args(this.index, this.title);
}
