import 'package:flutter/cupertino.dart';
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

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  // 初期化する処理
  Future<Database> initializeDatabase() async {
    // directory pathを取得
    // path_providerを利用することで iOS,Android にも対応できるようになる
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'todo.db';

    // openとcreateしたDBをreturnする
    var todoDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return todoDatabase;
  }
  
  void _createDb(Database db, int newVersion) async {
    debugPrint(' db create now ');
    await db.execute('CREATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }

  // Fetch
  // 取得したデータをリストで返却する
  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await this.database;

    // rawQueryはSQLステート
    // queryはsqfliteのヘルパー関数
    // var result = await db.rawQuery('SELECT * FROM $todoTable order by $colPriority ASC');
    var result = await db.query(todoTable, orderBy: '$colPriority ASC');
    return result;
  }

  // Insert
  // todo.toMap()は自作した関数。mapオブジェクトをinsertする
  Future<int> insertTodo(Todo todo) async {
    var db = await this.database;
    var result = await db.insert(todoTable, todo.toMap());
    return result;
  }

  // Update
  Future<int> updateTodo(Todo todo) async {
    var db = await this.database;
    var result = await db.update(todoTable, todo.toMap(), where: '$colId = ?', whereArgs: [todo.id]);
    return result;
  }

  // Delete
  Future<int> deleteTodo(int id) async {
    var db = await this.database;
    var result = await db.rawDelete('DELETE FROM $todoTable WHERE $colId = $id');
    return result;
  }

  // Get count
  Future<int> getCount() async {
    var db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $todoTable');
    var result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get Map List →  Todo List
  // DBの値をTodoの形式にして配列で返却
  Future<List<Todo>> getTodoList() async {
    var todoMapList = await getTodoMapList();
    int count = todoMapList.length;
    List<Todo> todoList = List<Todo>();

    for (int i = 0; i < count; i++) {
      todoList.add(Todo.fromMapObject(todoMapList[i]));
    }
    return todoList;
  }
}