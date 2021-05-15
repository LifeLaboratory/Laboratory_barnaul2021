import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hostel/presentation/shop/pages/shop_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:localstorage/localstorage.dart';
import 'package:hostel/presentation/shop/pages/shop_page.dart';

class Tasks {
  final int id_tasks;
  final int status;
  final int stars;
  final String description;
  final String picture;
  final String admin_name;

  Tasks({
    this.id_tasks,
    this.status,
    this.stars,
    this.picture,
    this.description,
    this.admin_name,
  });

  factory Tasks.fromJson(Map<String, dynamic> json) {
    return Tasks(
      id_tasks: json['id_tasks'],
      status: json['status'],
      stars: json['stars'],
      picture: json['picture'],
      description: json['description'],
      admin_name: json['admin_name'],
    );
  }
}

Future<List<Tasks>> fetchPhotos(http.Client client) async {
  final LocalStorage storage = new LocalStorage('todo_app');
  final response = await http.get(Uri.parse('http://2f5d91bd2225.ngrok.io/api/tasks'), headers: {
      "session": storage.getItem('session'),
    });

  // Use the compute function to run parsePhotos in a separate isolate.
  return compute(parsePhotos, response.body);
}

// A function that converts a response body into a List<Photo>.
List<Tasks> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Tasks>((json) => Tasks.fromJson(json)).toList();
}




class ActiveHelpTasks extends StatefulWidget {
  ActiveHelpTasks({Key key}) : super(key: key);

  @override
  _ActiveHelpTasks createState() => _ActiveHelpTasks();
}

class _ActiveHelpTasks extends State<ActiveHelpTasks> {
  Future<List<Tasks>> futureAlbum;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Активные щалачи',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Активные запросы'),
        ),
        body: Center (
          child: FutureBuilder<List<Tasks>>(
            future: fetchPhotos(http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? TasksList(tasks: snapshot.data)
                  : Center(child: CircularProgressIndicator());
            },
          ),
          ),
        ),
    );
  }
}

class TasksList extends StatelessWidget {
  final List<Tasks> tasks;

  TasksList({Key key, this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.all(30),
                  child: Column(
                      children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child:
                            Icon(
                              Icons.lightbulb,
                              color: Colors.yellow,
                              size: 30.0,
                              semanticLabel: 'Text to announce in accessibility modes',
                            ),
                          ),
                          Text('12'),
                          Text(tasks[index].description, textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
                      ]
                  ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
           // Navigator.pushNamed(context, "/addHelp");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ShopPage()),
            );
          },
          child: Icon(Icons.add, color: Colors.white, size: 29,),
          backgroundColor: Colors.blue,
          tooltip: 'Capture Picture',
          elevation: 5,
          splashColor: Colors.grey,
        ),
    );
  }
}
