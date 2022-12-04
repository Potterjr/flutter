// ignore_for_file: prefer_const_declarations

import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';
class DbHelper{
  static const databaseName = "MyDb.db";
  static final databaseVersion = 1;
  static final table = "My_table";
  static final columnId ='id';
  static final columnName = 'name';
  static final columnAge = 'age';
  static Database? database;


Future<Database> get _database async {
  if ( database != null) return database!;
    database = await initDatabase();
  return _database;
}

initDatabase() async {
 Directory documentsDirectory = await getApplicationDocumentsDirectory();
 String path = join(documentsDirectory.path, databaseName);
 return await openDatabase(
    path,
    version: databaseVersion,
    onCreate:_onCreate);
}

Future _onCreate(Database db, int version) async {
    await db.execute('''
           CREATE TABLE $table(
           $columnId INTEGER PRIMARY KEY,
           $columnName TEXT NOT NULL,
           $columnAge TEXT NOT NULL)
             ''');
  }
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
}

  Future<int?> queryRowCount() async {
      Database db = await instance.database;
      return Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }
}