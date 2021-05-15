/// lib/presentation/shop/pages/shop_page.dart

import 'package:flutter/material.dart';
import 'package:hostel/presentation/product_detail/pages/product_detail_page.dart';
import 'package:hostel/presentation/shop/pages/help_modal_timer.dart';
import 'package:localstorage/localstorage.dart';
/*
onPressed: () => Navigator.of(context).push(
            ProductDetailPage.route(),
          ),
 */


class HelpGrid extends StatelessWidget {
  final LocalStorage storage = new LocalStorage('todo_app');
  @override
  Widget build( BuildContext context) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        GestureDetector(
          onTap: (){
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                storage.setItem('text', 'Заменить лампочку в номере');
                return HelpTimer();
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child:
            Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Image.asset("assets/images/lamp.png"),
                  ),
                  Align (
                    alignment: Alignment.bottomCenter,
                    child: Text("Электрика", style: TextStyle(fontSize: 25, color: Colors.black),)
                  )
                ]
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                storage.setItem('text', 'Протечка крана в номере');
                return HelpTimer();
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child:
            Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Image.asset("assets/images/water.png"),
                  ),
                  Align (
                      alignment: Alignment.bottomCenter,
                      child: Text("Вода", style: TextStyle(fontSize: 25, color: Colors.black),)
                  )
                ]
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                storage.setItem('text', 'Уборка в номере');
                return HelpTimer();
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child:
            Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Image.asset("assets/images/clean.png"),
                  ),
                  Align (
                      alignment: Alignment.bottomCenter,
                      child: Text("Уборка", style: TextStyle(fontSize: 25, color: Colors.black),)
                  )
                ]
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                storage.setItem('text', 'Комната ');
                return HelpTimer();
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child:
            Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(40),
                    child: Image.asset("assets/images/dot.png"),
                  ),
                  Align (
                      alignment: Alignment.bottomCenter,
                      child: Text("Другое", style: TextStyle(fontSize: 25, color: Colors.black),)
                  )
                ]
            ),
          ),
        ),
      ],
    );
  }
}

class ShopPage extends StatelessWidget {
  static Route<dynamic> route() => MaterialPageRoute(
        builder: (context) => ShopPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Помощь"),
      ),
      body: Center(
        child: HelpGrid(),
      ),
    );
  }
}
