import 'run.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class myspl_scr extends StatefulWidget {
  const myspl_scr({Key? key}) : super(key: key);

  @override
  State<myspl_scr> createState() => _myspl_scrState();
}

class _myspl_scrState extends State<myspl_scr> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: NextScreen(),
      title: const Text("Emerald Splashu"),
      image: Image.network(
          "https://getonstream.com/wp-content/uploads/2021/06/Pogchamp.png"),
      //backgroundColor: Colors.white,
      gradientBackground: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.red, Colors.amberAccent, Colors.green, Colors.blue]),
      styleTextUnderTheLoader:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      photoSize: 100.0,
      loaderColor: Colors.red,
    );
  }
}
