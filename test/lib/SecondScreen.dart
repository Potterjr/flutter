// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unused_local_variable

import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String textsec1;
  final String textsec2;
 
  
  
  SecondScreen({Key? key, required this.textsec1, required this.textsec2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text('Second screen')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
     
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              textsec1,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 20,),
           Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              textsec2,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
                 Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
         " ans.toString()",
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          ElevatedButton(
            child: Text(
              'enter',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: () {
              printText(textsec1,textsec2);
            },
          )
        ],
      ),
    );
  }
   a(){
    int gettext =int.parse(textsec1);
    int gettext2 =int.parse(textsec2);
    int ans;
    ans= gettext+gettext2;
    return  ans;
  }
  void printText (String text1 ,String text2) {
   int gettext =int.parse(text1);
    int gettext2 =int.parse(text2);
    int ans;
    ans= gettext+gettext2;
   
 }
}
