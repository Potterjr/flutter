import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'main.dart';

class CameraWidget extends StatefulWidget {
  @override
  State createState() {
    // TODO: implement createState
    return CameraWidgetState();
  }
}

class CameraWidgetState extends State {
  PickedFile? imageFile = null;
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Image Camera"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
          
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text(
                  'Open image galley',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  _openGallery(context);
                },
              ),
                     ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text(
                  'open camera',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  _openCamera(context);
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Text(
                  'back',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  back(context);
                },
              ),
       
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile!;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
    });
    Navigator.pop(context);
  }

  void back(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(),
        ));
  }
}
