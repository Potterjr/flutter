import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  var webController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Scaffold(
        body: WebView(
          initialUrl: "http://192.168.1.9/web/login.html",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) async {
            webController = webViewController;
          },
          onPageFinished: (String url) {
            setState(() {
              webController.runJavascript('alert("hello wolrd")');
              webController.runJavascript("""
                  document.getElementsByName("uname")[0].value = "test";
                  document.getElementsByName("password")[0].value = "123456";
                  document.forms[0].submit();
                """);
              webController.runJavascript("""
                  document.getElementsByName("header")[0].style.display = "none";
              """);
            });
          },
        ),
      ),
    );
  }
}