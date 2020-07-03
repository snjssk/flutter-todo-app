import 'package:flutter/material.dart';

class TodoDetail extends StatefulWidget {
  @override
  _TodoDetailState createState() => _TodoDetailState();
}

class _TodoDetailState extends State<TodoDetail> {

  // first
  static var _selects = ['Hight', 'Low']

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('編集'),
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
                onChanged: null,
              ),
            )
          ],
        ),
      ),
    );
  }
}