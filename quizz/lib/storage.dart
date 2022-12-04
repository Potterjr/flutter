import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';

class Storage {
  String file = "app.txt";

  Future<String> get _localpath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get _localFile async {
    final path = await _localpath;
    return File("$path/$file");
  }

  Future<File> writefile(String contents) async {
    final file = await _localFile;
    return file.writeAsString(contents);
  }

  Future<String> readfile() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      print("$e");
      return '';
    }
  }
}
