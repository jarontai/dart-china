import 'package:dart_china/features/features.dart';
import 'package:dart_china/features/topic_list/view/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class HomePage extends StatefulWidget {
  static final routeName = '/';

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      mainScreen: TopicListPage(),
      menuScreen: MenuPage(),
      slideWidth: 250,
    );
  }
}
