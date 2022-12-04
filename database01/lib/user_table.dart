import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class user_table {
  static const _databaseName = "MyDb.db";
  static const _databaseVersion = 1;

  static const table = 'user';
  static const columnId = 'user_id';
  static const columnUser = 'user';
  static const columnPass = 'pass';

  user_table._privateContructor();
  static final user_table instance = user_table._privateContructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table(
      $columnId INTEGER PRIMARY KEY,
      $columnUser TEXT NOT NULL,
      $columnPass TEXT NOT NULL)
      ''');
  }

  Future<int?> findUser(String user, String pass) async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery(
        'SELECT * FROM $table WHERE $columnUser="$user" AND $columnPass="$pass"'));
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

  Future<List<Map<String, dynamic>>> queryAllRow() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId= ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId= ?', whereArgs: [id]);
  }
}
