// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, sized_box_for_whitespace, prefer_typing_uninitialized_variables, unused_label, camel_case_types, unnecessary_this, unnecessary_import




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}


class _LoginDemoState extends State<LoginDemo> {

  final id = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login Information"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/test2.jpg')),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: id,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'ID',
                    hintText: 'Enter ID'),
              ),
            ),
            // ignore: deprecated_member_use
            SizedBox(height: 10),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {Navigator.push(context,MaterialPageRoute(builder: (context) =>  page2()),);
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: 250,

              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(20)),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  id.text = ("");
                },
                child: Text(
                  'Clear',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class page2 extends StatefulWidget {
  
  const page2({Key? key}) : super(key: key);

  @override
  _page2State createState() => _page2State();
}

class _page2State extends State<page2> {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "showdata",
        home: Scaffold(
          appBar: AppBar(
            title: Text("data"),
          ),
          body: Column(children: [Expanded(child: createlist())],),
        ));
  }
}

Widget createlist() {
   List mylist = ['name1', 'name2', 'name3', 'name4'];
  return ListView.builder(
    itemCount: mylist.length,
    itemBuilder: (context, index) {

      return ListTile(
        title: Text(mylist[index]),
      );
    },
  );
}
