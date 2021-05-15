import 'dart:convert';

/// lib/presentation/home/pages/home_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';


class ProfileUser {
  final int id_user;
  final String name;
  final String telephone;
  final int number;
  final String picture;

  ProfileUser({
    this.id_user,
    this.name,
    this.number,
    this.telephone,
    this.picture,
  });

  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      id_user: json['id_user'],
      name: json['name'],
      number: json['number'],
      telephone: json['telephone'],
      picture: json['picture'],
    );
  }
}


Future<ProfileUser> fetchProfile() async {
  final LocalStorage storage = new LocalStorage('todo_app');
  final response = await http.get(Uri.parse('http://2f5d91bd2225.ngrok.io/api/user/profile'), headers: {
      "session": storage.getItem('session'),
    });
  if (response.statusCode == 200) {
    print(ProfileUser.fromJson(jsonDecode(response.body)).name);
    storage.setItem("number", ProfileUser.fromJson(jsonDecode(response.body)).number);
    return ProfileUser.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _Profile createState() => _Profile();

}

class _Profile extends State<Profile> {
  Future<ProfileUser> futureProfile;
  final formKey = GlobalKey<FormState>();
  String name;
  String phone;
  String birtday;
  String picture;

  @override
  void initState() {
    super.initState();
    futureProfile = fetchProfile();
  }
  
  void sendStatus(){
    final LocalStorage storage = new LocalStorage('todo_app');
    http.post(Uri.parse('http://2f5d91bd2225.ngrok.io/api/user/profile'), 
    headers: {
      "session": storage.getItem('session'),
    },
    body: {
      'name': this.name,
      'telephone': this.phone
    }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        padding: EdgeInsets.all(30),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          FutureBuilder<ProfileUser>(
            future: futureProfile,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                
                this.name = snapshot.data.name;
                this.phone = snapshot.data.telephone;
                this.picture = snapshot.data.picture;
                return Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 100.0,
                        backgroundImage:
                        NetworkImage('http://2f5d91bd2225.ngrok.io/' + this.picture),
                        backgroundColor: Colors.transparent,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child:
                        TextFormField(
                          onChanged: (text) {
                            this.name = text;
                          },
                          initialValue: this.name,
                          decoration: InputDecoration(labelText: 'Имя'),
                          validator: (value) => value.isEmpty ? 'Логин должен быть заполнен' : null,
                        ),
                      ),
                      TextFormField(
                          onChanged: (text) {
                            this.phone = text;
                          },
                          initialValue: this.phone,
                          decoration: InputDecoration(labelText: 'Телефон'),
                          validator: (value) => value.isEmpty ? 'Пароль должен быть заполнен' : null
                      )
                    ],
                  )
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            },
          ),
          
              Align(
                alignment: Alignment.bottomCenter,
                child: RaisedButton(
                onPressed: () {
                  sendStatus();
                },
                child: const Text('Сохранить', style: TextStyle(fontSize: 20)),
                color: Colors.blue,
                textColor: Colors.white,
                elevation: 5,
                ),
              )
        ]
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
      appBar: AppBar(
        title: Text("Профиль"),
      ),
      body: Center(
        child: Profile()
      )
    );
  }
}