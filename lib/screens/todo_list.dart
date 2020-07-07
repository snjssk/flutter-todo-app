import 'dart:async';
import 'package:flutter/material.dart';
import 'package:first_app/models/todo.dart';
import 'package:first_app/utils/database_helper.dart';
import 'package:first_app/screens/todo_detail.dart';
import 'package:sqflite/sqflite.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    // 値がない場合にここで初期化
    if (todoList == null) {
      todoList = List<Todo>();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('リスト'),
      ),
      body: getTodoListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail('add todo');
        },
        tooltip: 'add',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getTodoListView() {
    // title
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int postion) {
        return Card(
          color: Colors.white,
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Icon(Icons.keyboard_arrow_right),
            ),
            title: Text('Dummy Title', style: titleStyle,),
            subtitle: Text('Dummy Date'),
            trailing: Icon(Icons.delete, color: Colors.grey,),
            onTap: () {
              debugPrint('Tap');
              navigateToDetail('edit todo');
            },
          ),
        );
      },
    );
  }

  // 色を決める
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      default:
        return Colors.yellow;
    }
  }

  // アイコンを決める
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
      case 2:
        return Icon(Icons.keyboard_arrow_right);
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  // 削除処理
  void _delete(BuildContext context, Todo todo) async {
    // idを指定して削除
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      
    }
  }

  void navigateToDetail(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(title);
    }));
  }
}