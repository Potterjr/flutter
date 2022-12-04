// ignore_for_file: prefer_const_constructors, unnecessary_const

import 'package:flutter/material.dart';
import 'package:quiz_hw/statModel.dart';
import 'package:quiz_hw/storage.dart';

class stat extends StatefulWidget {
  const stat({Key? key}) : super(key: key);

  @override
  State<stat> createState() => _statState();
}

class _statState extends State<stat> {
  late List<StatModel> _stat;
  Storage storage = Storage();

  @override
  void initState() {
    readStat();
  }

  void readjson() async {
    final String response = await DefaultAssetBundle.of(context)
        .loadString('assets/json/stat.json');
    setState(() {
      _stat = statModelFromJson(response);
    });
  }

  void readStat() {
    storage.readfile().then((String value) {
      setState(() {
        if (value.isEmpty) {
          readjson();
        } else {
          _stat = statModelFromJson(value);
          _stat.sort((a, b) => b.score.compareTo(a.score));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Statistic"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        Navigator.popAndPushNamed(context, '/menu');
                      });
                    },
                    child: const Text("Back"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: const Text(
                    "Statistic",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 35),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _stat.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(
                            _stat[index].quiznum +
                                "\nScore : " +
                                _stat[index].score.toString() +
                                "/15 - " +
                                (_stat[index].score * 100 / 15)
                                    .toStringAsFixed(1) +
                                "%\nTime : " +
                                _stat[index].time +
                                "\nDate : " +
                                _stat[index].date.toString(),
                            textAlign: TextAlign.left,
                          ),
                        );
                      }),
                ),
              ],
            )) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
