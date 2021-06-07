import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../widgets/widgets.dart';
import '../../global/cubit/global_cubit.dart';
import '../../login/cubit/login_cubit.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final user = context.select((GlobalCubit b) => b.state.user);

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
              _buildFooter(context),
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
      width: 180,
      child: Column(
        children: [
          MenuItem(
            icon: Icons.home_outlined,
            text: '首页',
            route: '/',
            selected: selected == 0,
          ),
          MenuItem(
            icon: Icons.search_outlined,
            text: '搜索',
            route: '/search',
            selected: selected == 1,
          ),
          MenuItem(
            icon: Icons.notifications_outlined,
            text: '消息',
            route: '/',
            selected: selected == 2,
          ),
          MenuItem(
            icon: Icons.person_outlined,
            text: '我的',
            route: '/profile',
            selected: selected == 3,
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      width: 200,
      child: MenuItem(
        icon: Icons.exit_to_app_outlined,
        text: '注销',
        route: '/',
        selected: false,
        callback: () {
          context.read<LoginCubit>().logout();
        },
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    this.callback,
    required this.icon,
    required this.text,
    required this.route,
    required this.selected,
  }) : super(key: key);

  final VoidCallback? callback;
  final IconData icon;
  final String text;
  final String route;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
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
          callback?.call();
          ZoomDrawer.of(context)?.close();
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).popAndPushNamed(route);
          } else {
            Navigator.of(context).pushNamed(route);
          }
        },
      ),
    );
  }
}
