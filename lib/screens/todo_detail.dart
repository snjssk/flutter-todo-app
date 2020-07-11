import 'dart:async';
import 'package:flutter/material.dart';
import 'package:first_app/models/todo.dart';
import 'package:first_app/utils/database_helper.dart';
import 'package:intl/intl.dart';

class TodoDetail extends StatefulWidget {
  final String appBarTitle;
  final Todo todo;  // 画面遷移時に渡されるtodo

  TodoDetail(this.todo, this.appBarTitle);

  @override
  _TodoDetailState createState() => _TodoDetailState(this.todo, this.appBarTitle);
}

class _TodoDetailState extends State<TodoDetail> {

  static var _selects = ['High', 'Low'];
  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Todo todo;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _TodoDetailState(this.todo, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    // 親から渡した値がくれば、ここでセット
    titleController.text = todo.title;
    descriptionController.text = todo.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // first
            ListTile(
              title: DropdownButton(
                items: _selects.map((String dropDownStringItem) {
                  return DropdownMenuItem<String> (
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),

                value: getPriorityAsString(todo.priority),

                onChanged: (value) {
                  setState(() {
                    debugPrint('use selected $value');
                    updatePriorityAsInt(value);
                  });
                },
              ),
            ),

            // second
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: titleController,
                onChanged: (value) {
                  debugPrint('change TextField');
                  updateTitle();
                },
                decoration: InputDecoration(
                  labelText: 'title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ),
            ),

            // third
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: descriptionController,
                onChanged: (value) {
                  debugPrint('change description');
                  updateDescription();
                },
                decoration: InputDecoration(
                  labelText: 'description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                  )
                ),
              ),
            ),

            // fourth
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('save');
                          _save();
                        });
                      },
                    ),
                  ),

                  Container(width: 5.0,),

                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Delete',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint('delete');
                          _delete();
                        });
                      },
                    ),
                  )
                ],
              )
            )

          ],
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // high, lowを判定して１か２をセット
  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        todo.priority = 1;
        break;
      case 'Low':
        todo.priority = 2;
        break;
    }
  }

  // １か２を判定して、high or lowを返却
  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _selects[0];
        break;
      case 2:
        priority = _selects[1];
        break;
    }
    return priority;
  }

  // title, descriptionの変更をtodoにセット
  void updateTitle() {
    todo.title = titleController.text;
  }
  void updateDescription() {
    todo.description = descriptionController.text;
  }

  // save database
  void _save() async {

    // 先に画面を戻す
    moveToLastScreen();
    // 時刻
    todo.date = DateFormat.yMMMd().format(DateTime.now());

    // DB
    int result;
    if (todo.id != null) {
      // update
      result = await helper.updateTodo(todo);
    } else {
      // insert
      result = await helper.insertTodo(todo);
    }

    // エラーハンドリング
    if (result != 0) {
      _showAlertDialog('Status', 'OK');
    } else {
      _showAlertDialog('Status', 'NG');
    }
  }

  // delete
  void _delete() async {

    // 先に画面を戻す
    moveToLastScreen();

    // idがない場合はエラー
    if (todo.id == null) {
      _showAlertDialog('Status', 'NG - Delete');
      return;
    }
    int result = await helper.deleteTodo(todo.id);

    if (result != 0) {
      _showAlertDialog('Status', 'OK');
    } else {
      _showAlertDialog('Status', 'NG');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
      context: context,
      builder: (_) => alertDialog
    );
  }
}