import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void sendData () {
  print('tut');
  var url = Uri.parse('http://192.168.1.138:13451/api/tasks');
  Future<void> main() async {
    final client = http.Client();
    try {
      print(await client.post(url, body: {
        "description": "privet"
      }));
    } catch (err) {
      print(err);
    } finally {
      client.close();
    }
  }
  main();
}

class HelpTimer extends StatelessWidget {
  String _comment = '';

  @override
  Widget build( BuildContext context) {
    return Container(
      height: 300,
      color: Colors.amber,
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
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
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
                child: const Text('Close BottomSheet'),
                onPressed: () => sendData(),
              )
            ],
          ),
        )
      ),
    );
  }
}