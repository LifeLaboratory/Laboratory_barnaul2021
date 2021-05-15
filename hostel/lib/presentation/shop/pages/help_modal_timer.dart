import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HelpTimer extends StatelessWidget {
  String _comment = '';
  final LocalStorage storage = new LocalStorage('todo_app');

  Future<bool> sendData() async {
    var url = Uri.parse('http://2f5d91bd2225.ngrok.io/api/tasks');
      final client = http.Client();
      try {
        var res = await client.post(url, headers: {
          "session": storage.getItem('session'),
        }, body: {
          "description": _comment
        });
        _comment = '';

        Fluttertoast.showToast(
            msg: "Заявка успешно создана!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.amberAccent,
            textColor: Colors.green,
            fontSize: 16.0
        );
        return true;
      } catch (err) {
        print(err);
        return false;
      } finally {
        client.close();
      }
  }

  @override
  Widget build( BuildContext context) {
    return Container(
      height: 300,
      color: Colors.white,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40.0, left: 60, right: 60),
          child: Column(
            children: <Widget>[
              const Text('Вы хотите вывзать услугу *** \nВ номер **?', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Padding(
                padding: EdgeInsets.only(top: 25.0, left: 0, right: 0, bottom: 25.0),
                child: TextFormField(
                  initialValue: '$_comment',
                  onChanged: (text) {
                    _comment = text;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Комментарий (необезательно)',
                  ),
                  validator: (String value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              ElevatedButton(
                child: const Text('Отправить'),
                onPressed: () async => {
                  if (await sendData() == true) {
                    Navigator.pop(context),
                  }
                },
              )
            ],
          ),
        )
      ),
    );
  }
}