import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hostel/presentation/shop/pages/shop_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';


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
  final response = await http.get(Uri.parse('http://192.168.1.138:13451/api/tasks'), headers: {
      "session": "0b804514-9378-881b-672a-4ffa9fd2d4f3"
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
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
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
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Text(tasks[index].description);
      },
    );
  }
}
