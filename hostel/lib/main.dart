import 'package:flutter/material.dart';
import 'package:hostel/presentation/tabs/pages/tabs_page.dart';
import 'package:hostel/presentation/shop/pages/shop_page.dart';
import 'package:hostel/presentation/register/pages/register.pages.dart';
import 'package:localstorage/localstorage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => RegisterPage(),
        '/home': (BuildContext context) => TabsPage(),
        '/addHelp': (BuildContext context) => ShopPage(),
      },
    );
  }
}
