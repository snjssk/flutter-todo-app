import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:first_app/models/todo.dart';

class DatabaseHelper {

  // singleton
  static DatabaseHelper _databaseHelper;
  static Database _database;

  // database
  String todoTable = 'todo_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  // 初期化
  Future<Database> initializeDatabase() async {
    // directory path
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'todo.db';

    // openとcreate
    // したDBをreturnする
    var todoDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }
  
  void _createDb(Database db, int newVersion) async {
    await db.execute('CRATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colTitle TEXT, $colDescription TEXT, $colPriority TEXT, $colDate TEXT)');
  }
}