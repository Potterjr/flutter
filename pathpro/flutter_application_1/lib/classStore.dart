// ignore_for_file: unused_import, camel_case_types, unused_element, file_names

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class classstore {
  String myfile = "app.txt";
  Future<String> get _localPath async {
    final diractory = await getApplicationDocumentsDirectory();
    return diractory.path;
  }

  Future<File> get _localfile async {
    final path = await _localPath;
    return File('$path/$myfile');
  }

  Future<File> writefile(String contents) async {
    final file = await _localfile;
    return file.writeAsString(contents);
  }

  Future<String> readFile() async {
    try {
      final file = await _localfile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      return 'error';
    }
  }
}
