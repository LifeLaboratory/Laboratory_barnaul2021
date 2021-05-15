/// lib/presentation/shop/pages/shop_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
    builder: (context) => LoginPage(),
  );
  final formKey = GlobalKey<FormState>();
  String _login;
  String _password;
  String _err;

  Future<bool> validation () async {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      final LocalStorage storage = new LocalStorage('todo_app');
      final apiUrl = Uri.parse("http://2f5d91bd2225.ngrok.io/api/user/login");
      var result = await http.post(apiUrl, body: {
        "login": _login,
        "password": _password
      });
      var resData = json.decode(result.body);
      print(resData);
      if (resData['session'] != null) {
        storage.setItem('session', resData['session']);
        return true;
      } else {
        Fluttertoast.showToast(
            msg: resData['error'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return false;
      }
    } else {
      return false;
      print('reg - err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Авторизация"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        margin: const EdgeInsets.only(top: 80),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset("assets/images/logo.png", height: 125,),
                Container(
                  margin: const EdgeInsets.only(top: 90),
                  child:
                  TextFormField(
                    onChanged: (text) {
                      _login = text;
                    },
                    decoration: InputDecoration(labelText: 'Login'),
                    validator: (value) => value.isEmpty ? 'Логин должен быть заполнен' : null,
                  ),
                ),
                TextFormField(
                    onChanged: (text) {
                      _password = text;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) => value.isEmpty ? 'Пароль должен быть заполнен' : null
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child:
                  RaisedButton(
                      padding: EdgeInsets.all(10.0),
                      child: Text("Войти", style: TextStyle(fontSize: 20.0),),
                      onPressed: () async => {
                        if (await validation() == true) {
                          //Navigator.pushNamed(context, '/home')
                          Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false)
                        }
                      }
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false);
                  },
                  child: new Text("Регистрация", textAlign: TextAlign.center),
                )
              ],
            )
        ),
      ),
    );
  }
}
