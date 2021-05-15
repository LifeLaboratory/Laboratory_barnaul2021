/// lib/presentation/shop/pages/shop_page.dart

import 'package:flutter/material.dart';
import 'package:hostel/presentation/product_detail/pages/product_detail_page.dart';
import 'package:hostel/presentation/shop/pages/help_modal_timer.dart';
/*
onPressed: () => Navigator.of(context).push(
            ProductDetailPage.route(),
          ),
 */


class HelpGrid extends StatelessWidget {
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
                    child: Text("Сеть", style: TextStyle(fontSize: 25, color: Colors.black),)
                  )
                ]
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            print("Container clicked");
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
            print("Container clicked");
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
            print("Container clicked");
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child:
            Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Image.asset("assets/images/eat.png"),
                  ),
                  Align (
                      alignment: Alignment.bottomCenter,
                      child: Text("Еда", style: TextStyle(fontSize: 25, color: Colors.black),)
                  )
                ]
            ),
          ),
        ),
        GestureDetector(
          onTap: (){
            print("Container clicked");
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
