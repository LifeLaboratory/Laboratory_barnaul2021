/// lib/presentation/shop/pages/shop_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => RegisterPage(),
  );
  final formKey = GlobalKey<FormState>();
  String _login;
  String _password;
  String _err;

  void validation () async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      final LocalStorage storage = new LocalStorage('todo_app');
      final apiUrl = Uri.parse("http://192.168.1.138:13451/api/user/register");
        var result = await http.post(apiUrl, body: {
          "login": _login,
          "password": _password
        });
        var resData = json.decode(result.body);
        _err = '12';
        print(resData);
        if (resData['session'] != null) {
          storage.setItem('session', resData['session']);
        } else {
          Fluttertoast.showToast(
              msg: "resData['err']",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }


    } else {
      print('reg - err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Регострация"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                onChanged: (text) {
                  _login = text;
                },
                decoration: InputDecoration(labelText: 'Login'),
                validator: (value) => value.isEmpty ? 'Логин должен быть заполнен' : null,
              ),
              TextFormField(
                  onChanged: (text) {
                    _password = text;
                  },
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => value.isEmpty ? 'Пароль должен быть заполнен' : null
              ),
              RaisedButton(
                padding: EdgeInsets.all(10.0),
                child: Text("Регистрация", style: TextStyle(fontSize: 20.0),),
                onPressed: validation,
              )
            ],
          )
        ),
      ),
    );
  }
}
