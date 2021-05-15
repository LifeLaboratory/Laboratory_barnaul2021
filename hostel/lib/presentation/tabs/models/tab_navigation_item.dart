import 'package:flutter/material.dart';
import 'package:hostel/presentation/home/pages/home_page.dart';
import 'package:hostel/presentation/search/pages/search_page.dart';
import 'package:hostel/presentation/shop/pages/active_help_tasks.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: HomePage(),
          icon: Icon(Icons.home),
          title: Text("Профиль"),
        ),
        TabNavigationItem(
          page: ActiveHelpTasks(),
          icon: Icon(Icons.shopping_basket),
          title: Text("Помощь"),
        ),
      ];
}
