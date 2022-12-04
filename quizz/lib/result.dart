import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quiz_hw/statModel.dart';
import 'package:quiz_hw/storage.dart';
import 'package:intl/intl.dart';

class result extends StatefulWidget {
  const result(
      {Key? key,
      required this.quiznum,
      required this.score,
      required this.time})
      : super(key: key);
  final String quiznum;
  final int score;
  final String time;
  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
  final now = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  late List<StatModel> _stat;
  File file = File('assets/json/stat.json');
  Storage storage = Storage();
  String kk = "";

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
        _stat = statModelFromJson(value);
      });
    });
  }

  void writejson() {
    storage.readfile().then((String value) {
      setState(() {
        if (value.isEmpty) {
          readjson();
        } else {
          _stat = statModelFromJson(value);
        }
      });
    });
    final String formatted = formatter.format(now);
    StatModel newstat = StatModel(
        quiznum: widget.quiznum,
        score: widget.score,
        date: formatted,
        time: widget.time);
    _stat.add(newstat);
    storage.writefile(statModelToJson(_stat));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readStat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz result"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: const Text(
                "Score",
                style: TextStyle(fontSize: 35),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(padding: EdgeInsets.all(15.0)),
            SizedBox(
              width: double.infinity,
              child: Text(
                  "Correct : " +
                      ((widget.score / 15) * 100).toStringAsFixed(2) +
                      " %",
                  textAlign: TextAlign.center),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                  "Incorrect : " +
                      (((15 - widget.score) / 15) * 100).toStringAsFixed(2) +
                      " %",
                  textAlign: TextAlign.center),
            ),
            SizedBox(
              width: double.infinity,
              child: Text("Time : " + widget.time, textAlign: TextAlign.center),
            ),
            Padding(padding: EdgeInsets.all(15.0)),
            SizedBox(
              width: double.infinity,
              child: const Text(
                "Grade",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(padding: EdgeInsets.all(15.0)),
            SizedBox(
              width: double.infinity,
              child: Text(grade(widget.score),
                  style: TextStyle(fontSize: 35), textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                  onPressed: () {
                    //readStat();
                    writejson();
                    setState(() {
                      Navigator.popAndPushNamed(context, 'stat');
                    });
                  },
                  child: const Text("OK")),
            ),
          ],
        ),
      ),
    );
  }

  String grade(int score) {
    String grade = "";
    double scored = score / 15 * 100;
    if (scored >= 80) grade = "A";
    if (scored <= 79) grade = "B+";
    if (scored <= 74) grade = "B";
    if (scored <= 69) grade = "C+";
    if (scored <= 64) grade = "C";
    if (scored <= 59) grade = "D+";
    if (scored <= 54) grade = "D";
    if (scored <= 49) grade = "F";
    return grade;
  }
}
