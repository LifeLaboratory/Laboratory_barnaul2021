import 'package:flutter/material.dart';
import 'package:hostel/presentation/shop/pages/shop_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActiveHelpTasks extends StatelessWidget {

  static Route<Widget> route() => MaterialPageRoute(
    builder: (context) => ActiveHelpTasks(),
  );


  final apiUrl = Uri.parse("http://192.168.1.138:13451/api/tasks");
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
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return Row(
                    children: snapshot.data.map((item) => new Text(item['admin_name']))
                        .toList());
              } else {
                return Text('netu');
              }
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
  }
}


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