import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:dart_china/features/app/cubit/app_cubit.dart';
import 'package:dart_china/widgets/widgets.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppCubit b) => b.state.user);

    return Scaffold(
      backgroundColor: Color(0xFF657599),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              _buildHeader(
                avatar: user?.avatar,
                username: user?.username,
                name: user?.name,
              ),
              SizedBox(height: 150),
              _buildBody(context, selected),
              SizedBox(height: 120),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader({String? avatar, String? username, String? name}) {
    return Container(
      child: Row(
        children: [
          AvatarButton(
            size: 30,
            avatarUrl: avatar ?? '',
            onPressed: () {},
          ),
          SizedBox(
            width: 6,
          ),
          Column(
            children: [
              Text(
                username ?? '-',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, int selected) {
    return Container(
      width: 200,
      // color: Colors.red,
      child: Column(
        children: [
          MenuItem(
            icon: Icons.home_outlined,
            text: 'Home',
            route: '/',
            selected: selected == 0,
          ),
          MenuItem(
            icon: Icons.question_answer_outlined,
            text: 'Activities',
            route: '/',
            selected: selected == 1,
          ),
          MenuItem(
            icon: Icons.person_outlined,
            text: 'Profile',
            route: '/',
            selected: selected == 2,
          ),
          MenuItem(
            icon: Icons.settings_outlined,
            text: 'Settings',
            route: '/',
            selected: selected == 3,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      child: MenuItem(
        icon: Icons.exit_to_app_outlined,
        text: 'Sign Out',
        route: '/sign_out',
        selected: false,
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.route,
    required this.selected,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final String route;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        tileColor: selected ? Color(0xFFa7aec2) : null,
        horizontalTitleGap: 0,
        leading: Icon(
          icon,
          color: selected ? Colors.white : Colors.grey.shade300,
        ),
        title: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey.shade300,
          ),
        ),
        onTap: () {
          ZoomDrawer.of(context)?.close();
          Navigator.of(context).popAndPushNamed(route);
        },
      ),
    );
  }
}
