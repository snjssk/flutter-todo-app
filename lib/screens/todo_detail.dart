import 'dart:async';
import 'package:flutter/material.dart';
import 'package:first_app/models/todo.dart';
import 'package:first_app/utils/database_helper.dart';
import 'package:intl/intl.dart';

class TodoDetail extends StatefulWidget {

  String appBarTitle;
  TodoDetail(this.appBarTitle);

  @override
  _TodoDetailState createState() => _TodoDetailState(this.appBarTitle);
}

class _TodoDetailState extends State<TodoDetail> {

  static var _selects = ['High', 'Low'];
  String appBarTitle;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _TodoDetailState(this.appBarTitle);

  @override
  Widget build(BuildContext context) {
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
                value: 'Low',
                onChanged: (value) {
                  setState(() {
                    debugPrint('use selected $value');
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
    Navigator.pop(context);
  }
}