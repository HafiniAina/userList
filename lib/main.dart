// import 'package:flutter/material.dart';
// import 'dart:async'; //has future class building to it
// //import 'package:syncfusion_flutter_datagrid/datagrid.dart'; //pub.dev utk tgk pakej yg kena install
// import 'package:http/http.dart' as http;
// import 'dart:convert'; //initialising json data


// void main() {
//   runApp(new MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
  
// //create a method to mapped json data to list
// //by defining a method that return the future list of user
// //within it, define a list to store response from online data source
// // to use the http related api, u need to import http package first in yummy file

//   Future<List<User>> _getUsers() async{
//     var data = await http.get(Uri.parse(
//       'https://classroom.google.com/u/0/w/Mzc2MDkxMzMwNTQy/tc/MzIwNDI1MDg5NTEw'));

//     var jsonData = json.decode(data.body);

//     List<User> users = [];

//     for (var u in jsonData) {
//         User user = User(u["id"], u["firstName"], u["lastName"], u["username"], u["lastSeenTime"], u["avatar"], u["status"]);
   
//         users.add(user);
//     }

//     print(users.length);
// }



//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: new Text(widget.title),
//       ),
//       body: Container(
//         child: FutureBuilder(
//           future: _getUsers(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             return ListView.builder(
//               itemCount: snapshot.data.length,
//               itemBuilder: (BuildContext context, int index) {
                
//                 return ListTile(
//                   title: Text(snapshot.data[index].name),
//                 );
//               },
//             );
//           },
//         ),

//       ),
//     );
//   }
// }



  
// class User {
//    final int id;
//    final String firstName;
//    String lastName;
//    String username;
//    String lastSeenTime;
//    String avatar;
//    String status;

//    User(this.id, this.firstName, this.lastName, this.username, this.lastSeenTime,this.avatar, this.status,);
// }
   


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(title: 'All Data'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  List _items = [];

  //Fetch content from json file
  Future<void>readJson()async{
    final dynamic response = await rootBundle.loadString('asset/data.json');
    final data = await jsonDecode(response);
    setState(() {
      _items = data;
    });
    print(_items[5].containsKey("avatar") );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            //Display data loaded from json file
            _items.isNotEmpty ? Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context,index){
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          child: CircleAvatar(
                            backgroundImage: _items[index].containsKey("avatar") ? NetworkImage(_items[index]["avatar"]) : NetworkImage("https://www.vhv.rs/dpng/d/526-5268314_empty-avatar-png-user-icon-png-transparent-png.png"),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(_items[index]["first_name"] + " " + _items[index]["last_name"]),
                              Text(_items[index]["username"]),
                              Text(_items[index].containsKey("status") ? _items[index]["status"] : "N/A")
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Text(_items[index]["last_seen_time"])
                            ],
                          ),
                        )
                      ],
                    ),
                    // child: ListTile(
                    //   leading: Text(_items[index]["id"].toString()),
                    //   title: Text(_items[index]["first_name"].toString() + " " + _items[index]["last_name"].toString()),
                    //   subtitle: Text(_items[index]["username"].toString()),
                    //   ),
                  );
                }
              ),
            ) : Container()
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: readJson,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}