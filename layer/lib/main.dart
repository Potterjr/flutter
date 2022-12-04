import 'package:flutter/material.dart';
import 'package:layer/page2.dart';

void main() {
  runApp(const MyApp(
    title: 'test',
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required String title}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: 'main',
      routes: {
        'main': (context) => const MyHomePage(
              title: "page1",
            ),
        'second': (context) => const screen2(
              title: "page2",
            ),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[800],
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            _scaffoldkey.currentState?.openDrawer();
          },
          icon: Icon(Icons.person),
          color: Colors.red,
        ),
        title: const Text("Yolo page 1"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      drawer: Container(
        width: 250,
        color: Colors.yellow,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Test",
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.amber,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                //Navigator.pushNamed(context, 'second');
                navi_me(context);
              },
              child: Text("Click me"),
            )
          ],
        ),
      ),
    );
  }

  void navi_me(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return const screen2(title: 'page 2');
        },
        transitionsBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.1),
              end: const Offset(0.0, 0.0),
            ).animate(CurvedAnimation(
                parent: animation, curve: Curves.linearToEaseOut)),
            child: child,
          );
        },
        transitionDuration: const Duration(seconds: 3),
      ),
    );
  }
}
