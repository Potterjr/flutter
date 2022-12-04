import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:quiz_hw/quizModel.dart';
import 'package:quiz_hw/result.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class quiz extends StatefulWidget {
  const quiz({Key? key, required this.index, required this.title})
      : super(key: key);

  final String index;
  final String title;
  @override
  State<quiz> createState() => _quizState();
}

bool end = false;

class _quizState extends State<quiz> {
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 600;

  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final StopWatchTimer countup = StopWatchTimer();

  String time = "";
  final _isHours = false;
  int choice = 0;
  int cur = 0;
  int score = 0;
  var rand = <int>[];
  Set<int> setint = Set();
  late List<QuizModel> _quiz;
  Set<int> setx = Set();
  var randx = <int>[];

  void readjson() async {
    final String response = await DefaultAssetBundle.of(context)
        .loadString('assets/json/data' + widget.index + '.json');
    setState(() {
      _quiz = quizModelFromJson(response);
    });
  }

  onEnd() {
    countup.dispose();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Time's up!"),
            content: const Text("Time's up, the quiz is over."),
            actions: [
              TextButton(
                  onPressed: () {
                    end = false;
                    endQuiz();
                  },
                  child: const Text("OK"))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    readjson();
    curR();
    curX();
    countup.onExecute.add(StopWatchExecute.start);
  }

  @override
  void dispose() async {
    super.dispose();
    await countup.dispose();
  }

  void endQuiz() {
    countup.dispose();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => result(
                  quiznum: widget.title,
                  score: score,
                  time: time,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CountdownTimer(
                  endTime: endTime,
                  onEnd: onEnd,
                  textStyle: const TextStyle(fontSize: 35),
                ),
                StreamBuilder<int>(
                  stream: countup.rawTime,
                  initialData: countup.rawTime.value,
                  builder: (context, snap) {
                    final value = snap.data!;
                    final displayTime =
                        StopWatchTimer.getDisplayTime(value, hours: _isHours);
                    time = displayTime.toString();
                    return Column();
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    (cur + 1).toString() + ". " + _quiz[rand[cur]].title,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: _quiz[rand[cur]].choice.length,
                      itemBuilder: (BuildContext context, int index) {
                        var q = _quiz[rand[cur]].choice;
                        return ListTile(
                          leading: Radio(
                            value: q[randx[index]].id,
                            groupValue: choice,
                            onChanged: (int? value) {
                              setState(() {
                                choice = value!;
                              });
                            },
                          ),
                          title: Text(q[randx[index]].title),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  if (choice == _quiz[rand[cur]].answerId) {
                                    score++;
                                  }
                                  if (cur < 14) {
                                    cur++;
                                    choice = 0;
                                    curX();
                                    //_counter.value += 1;
                                  } else {
                                    endQuiz();
                                  }
                                });
                              },
                              child: const Text("Next")),
                        ),
                      ]),
                ),
              ],
            )));
  }

  void curR() {
    while (setint.length < 15) {
      setint.add(Random().nextInt(20));
    }
    for (var element in setint) {
      rand.add(element);
    }
  }

  void curX() {
    setx.clear();
    randx.clear();
    while (setx.length < 4) {
      setx.add(Random().nextInt(4));
    }
    for (var element in setx) {
      randx.add(element);
    }
  }
}
