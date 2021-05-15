import 'package:flutter/material.dart';
import 'package:hostel/presentation/shop/pages/shop_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


class Tasks {
  final int id_tasks;
  final int status;
  final String description;
  final String admin_name;

  Tasks({
    this.id_tasks,
    this.status,
    this.description,
    this.admin_name,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      id_tasks: json['id_tasks'],
      status: json['status'],
      description: json['description'],
      admin_name: json['admin_name'],
    );
  }
}

Future<Tasks> fetchTasks() async {
  print("hello");
  final response =
      await http.get(Uri.parse('http://192.168.1.138:13451/api/tasks'));
  print(response);
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Tasks.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}



class ActiveHelpTasks extends StatefulWidget {
  ActiveHelpTasks({Key key}) : super(key: key);

  @override
  _ActiveHelpTasks createState() => _ActiveHelpTasks();
}

class _ActiveHelpTasks extends State<ActiveHelpTasks> {
  Future<Tasks> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Tasks>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.description);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

/*
class ActiveHelpTasks extends StatelessWidget {

  static Route<Widget> route() => MaterialPageRoute(
    builder: (context) => ActiveHelpTasks(),
  );
*/
/*
  final apiUrl = Uri.parse("http://127.0.0.1:13451/api/tasks");
  Future<List<Widget>> fetchUsers() async {
    var result = await http.get(apiUrl, headers: {
      "session": "0b804514-9378-881b-672a-4ffa9fd2d4f3"
    });
    print(json.decode(result.body));
    return json.decode(result.body);
  }

  @override
  Widget build( BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
        ),
        body: Scaffold(
          body: Container(
            child: FutureBuilder<List<Widget>>(
            future: fetchUsers(),

            builder: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${items[index]}'),
            );
          },
        ),
            // builder: (BuildContext context, AsyncSnapshot snapshot) {
            //   ListView.builder(
            //     padding: const EdgeInsets.all(16.0),
            //     itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            //     itemBuilder: (context, index) {
            //       new Text(snapshot.data[index]['admin_name']);
            //     }
            // );
              // if (snapshot.data != null) {
              //   return Row(
              //       children: snapshot.data.map((item) => new Text(item['admin_name']))
              //           .toList());
              // } else {
              //   return Text('netu');
              // }
            })
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //Navigator.of(context).pushNamed('/addHelp');
              Navigator.pushNamed(context, '/addHelp');
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        ),

    );
  }*/
//}


/*Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Navigator.of(context).pushNamed('/addHelp');
            Navigator.pushNamed(context, '/addHelp');
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
      ),

 */