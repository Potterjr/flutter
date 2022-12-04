import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWeb extends StatefulWidget {
  const MyWeb({Key? key}) : super(key: key);

  @override
  _MyWebState createState() => _MyWebState();
}

class _MyWebState extends State<MyWeb> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text("text Webview"),
          ),
          body: const WebView(
            initialUrl: "http://192.168.1.9/web/login.html",
            javascriptMode: JavascriptMode.unrestricted,
   
          )),
    );
  }
}
