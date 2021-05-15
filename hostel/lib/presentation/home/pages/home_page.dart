/// lib/presentation/home/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

Future<String> fetchAlbum() async {
  final response =
  await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1'));
}

class Profile extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  String name;
  String phone;
  String birtday;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(30),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CircleAvatar(
                  radius: 100.0,
                  backgroundImage:
                  NetworkImage('https://via.placeholder.com/150'),
                  backgroundColor: Colors.transparent,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child:
                  TextFormField(
                    onChanged: (text) {
                      //_login = text;
                    },
                    decoration: InputDecoration(labelText: 'Имя'),
                    validator: (value) => value.isEmpty ? 'Логин должен быть заполнен' : null,
                  ),
                ),
                TextFormField(
                    onChanged: (text) {
                      //_password = text;
                    },
                    decoration: InputDecoration(labelText: 'Телефон'),
                    validator: (value) => value.isEmpty ? 'Пароль должен быть заполнен' : null
                ),
                TextFormField(
                    onChanged: (text) {
                      //_password = text;
                    },
                    decoration: InputDecoration(labelText: 'День рождения'),
                    validator: (value) => value.isEmpty ? 'Пароль должен быть заполнен' : null
                )
              ],
            )
        ),
    );
  }
}
class HomePage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Профиль"),
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Profile(),
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                onPressed: () {},
                child: const Text('Сохранить', style: TextStyle(fontSize: 20)),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 5,
                ),
              )
        ]
      ),
      )
    );
  }
}