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
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('リスト'),
      ),
      body: getTodoListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Todo('', '', 2), 'add todo');
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
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getPriorityColor(this.todoList[position].priority),
              child: getPriorityIcon(this.todoList[position].priority),
            ),
            title: Text(this.todoList[position].title, style: titleStyle,),
            subtitle: Text(this.todoList[position].date),
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, todoList[position]);
              },
            ),
            onTap: () {
              debugPrint('Tap');
              navigateToDetail(this.todoList[position], 'edit todo');
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
      _showSnackBar(context, 'Delete Success');
      updateListView();
    }
  }

  // スナックバー
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  // 画面遷移
  // add, editでそれぞれ引数にtodoの値をもらう
  // また返り値をもらうため async,await となる
  void navigateToDetail(Todo todo, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(todo, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  // 更新処理
  // DBに接続してgetTodoListでリストを取得してstateにセット
  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {

      Future<List<Todo>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.count = todoList.length;
        });
      });
    });
  }
}