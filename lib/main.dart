import 'package:flutter/material.dart';
import 'package:first_app/models/todo.dart';
import 'package:first_app/utils/database_helper.dart';
import 'package:first_app/screens/todo_list.dart';
import 'package:first_app/screens/todo_detail.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: TodoListPage(),
      home: TodoList()
    );
  }
}

// 一覧
//class TodoListPage extends StatefulWidget {
//  @override
//  _TodoListPageState createState() => _TodoListPageState();
//}
//class _TodoListPageState extends State<TodoListPage> {
//  // Todoリストのデータ
//  List<String> todoList = [];
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('リスト一覧'),
//      ),
//
//      body: ListView.builder(
//        itemCount: todoList.length,
//        itemBuilder: (context, index) {
//          return Card(
//            child: ListTile(
//              title: Text(todoList[index]),
//            ),
//          );
//        },
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () async {
//          // "push"で新規画面に遷移
//          // リスト追加画面から渡される値を受け取る
//          final newListText = await Navigator.of(context).push(
//            MaterialPageRoute(builder: (context) {
//              // 遷移先の画面としてリスト追加画面を指定
//              return TodoAddPage();
//            }),
//          );
//          if (newListText != null) {
//            // キャンセルした場合は newListText が null となるので注意
//            setState(() {
//              // リスト追加
//              todoList.add(newListText);
//            });
//          }
//        },
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}
//
//// 詳細
//class TodoAddPage extends StatefulWidget {
//  @override
//  _TodoAddPageState createState() => _TodoAddPageState();
//}
//
//class _TodoAddPageState extends State<TodoAddPage> {
//  // 入力されたテキストをデータとして持つ
//  String _text = '';
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('リスト追加!'),
//      ),
//      body: Container(
//        padding: EdgeInsets.all(64),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            // 入力されたテキストを表示
//            Text(_text, style: TextStyle(color: Colors.blue)),
//            // テキスト入力
//            TextField(
//              // 入力されたテキストの値を受け取る（valueが入力されたテキスト）
//              onChanged: (String value) {
//                // データが変更したことを知らせる（画面を更新する）
//                setState(() {
//                  // データを変更
//                  _text = value;
//                });
//              },
//            ),
//            Container(
//              // 横幅いっぱいに広げる
//              width: double.infinity,
//              // リスト追加ボタン
//              child: RaisedButton(
//                color: Colors.blue,
//                onPressed: () {
//                  // *** 追加する部分 ***
//                  // "pop"で前の画面に戻る
//                  // "pop"の引数から前の画面にデータを渡す
//                  Navigator.of(context).pop(_text);
//                },
//                child: Text('リスト追加', style: TextStyle(color: Colors.white)),
//              ),
//            ),
//          ]
//        ),
//      )
//    );
//  }
//}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  // This widget is the home page of your application. It is stateful, meaning
//  // that it has a State object (defined below) that contains fields that affect
//  // how it looks.
////
//  // This class is the configuration for the state. It holds the values (in this
//  // case the title) provided by the parent (in this case the App widget) and
//  // used by the build method of the State. Fields in a Widget subclass are
//  // always marked "final".
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      // This call to setState tells the Flutter framework that something has
//      // changed in this State, which causes it to rerun the build method below
//      // so that the display can reflect the updated values. If we changed
//      // _counter without calling setState(), then the build method would not be
//      // called again, and so nothing would appear to happen.
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // This method is rerun every time setState is called, for instance as done
//    // by the _incrementCounter method above.
//    //
//    // The Flutter framework has been optimized to make rerunning build methods
//    // fast, so that you can just rebuild anything that needs updating rather
//    // than having to individually change instances of widgets.
//    return Scaffold(
//      appBar: AppBar(
//        // Here we take the value from the MyHomePage object that was created by
//        // the App.build method, and use it to set our appbar title.
//        title: Text(widget.title),
//      ),
//      body: Center(
//        // Center is a layout widget. It takes a single child and positions it
//        // in the middle of the parent.
//        child: Column(
//          // Column is also a layout widget. It takes a list of children and
//          // arranges them vertically. By default, it sizes itself to fit its
//          // children horizontally, and tries to be as tall as its parent.
//          //
//          // Invoke "debug painting" (press "p" in the console, choose the
//          // "Toggle Debug Paint" action from the Flutter Inspector in Android
//          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//          // to see the wireframe for each widget.
//          //
//          // Column has various properties to control how it sizes itself and
//          // how it positions its children. Here we use mainAxisAlignment to
//          // center the children vertically; the main axis here is the vertical
//          // axis because Columns are vertical (the cross axis would be
//          // horizontal).
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'クリックしてね:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
//    );
//  }
//}
