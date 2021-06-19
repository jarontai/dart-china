import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features.dart';
import 'menu_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    context.read<GlobalCubit>().checkNotification();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      mainScreen: TopicListPage(),
      menuScreen: MenuPage(),
      slideWidth: 235,
    );
  }
}
