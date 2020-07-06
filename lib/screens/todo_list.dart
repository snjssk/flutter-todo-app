import 'package:first_app/screens/todo_detail.dart';
import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
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

  void navigateToDetail(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(title);
    }));
  }
}