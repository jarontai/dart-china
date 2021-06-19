import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../common.dart';
import '../../../widgets/widgets.dart';
import '../../global/cubit/global_cubit.dart';
import '../../login/cubit/login_cubit.dart';

typedef RouteGenCallback = String Function();

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Color(0xFF657599),
        body: InkWell(
          onTap: () {
            ZoomDrawer.of(context)?.close();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                _buildHeader(context),
                SizedBox(height: 150),
                _buildBody(context, selected),
                SizedBox(height: 120),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final userLogin = context.select((GlobalCubit b) => b.state.userLogin);
    final user = context.select((GlobalCubit b) => b.state.user);

    return Container(
      child: Row(
        children: [
          AvatarButton(
            size: 30,
            avatarUrl: userLogin ? user?.avatar : null,
            onPressed: () {
              ZoomDrawer.of(context)?.close();
              if (!userLogin) {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).popAndPushNamed(Routes.login);
                } else {
                  Navigator.of(context).pushNamed(Routes.login);
                }
              } else {
                Navigator.of(context)
                    .pushNamed(Routes.profile, arguments: user!.username);
              }
            },
          ),
          SizedBox(
            width: 6,
          ),
          Column(
            children: [
              Text(
                userLogin ? user?.username ?? '' : '',
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
      child: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) {
          return Column(
            children: [
              _MenuItem(
                icon: Icons.home_outlined,
                text: '首页',
                selected: selected == 0,
              ),
              _MenuItem(
                icon: Icons.search_outlined,
                text: '搜索',
                routeGen: () => Routes.search,
                selected: selected == 1,
              ),
              _MenuItem(
                icon: Icons.notifications_outlined,
                text: '消息',
                routeGen: () => Routes.notification,
                selected: selected == 2,
                badge: state.hasNotification,
              ),
              _MenuItem(
                icon: Icons.person_outlined,
                text: '我的',
                routeGen: () {
                  var route = '';

                  final state = context.read<GlobalCubit>().state;
                  final userLogin = state.userLogin;
                  final user = state.user;
                  if (userLogin) {
                    Navigator.of(context)
                        .pushNamed(Routes.profile, arguments: user!.username);
                  } else {
                    route = Routes.login;
                  }
                  return route;
                },
                selected: selected == 3,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final userLogin = context.select((GlobalCubit b) => b.state.userLogin);

    return userLogin
        ? Container(
            width: 200,
            child: _MenuItem(
              icon: Icons.exit_to_app_outlined,
              text: '登出',
              routeGen: () => '/',
              selected: false,
              callback: () {
                context.read<LoginCubit>().logout();
                EasyLoading.showToast(Messages.logoutSuccess);
              },
            ),
          )
        : SizedBox.shrink();
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem({
    Key? key,
    this.callback,
    required this.icon,
    required this.text,
    this.routeGen,
    required this.selected,
    this.canRoute = true,
    this.badge = false,
  }) : super(key: key);

  final VoidCallback? callback;
  final IconData icon;
  final String text;
  final RouteGenCallback? routeGen;
  final bool selected;
  final bool canRoute;
  final bool badge;

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
        leading: badge
            ? Badge(
                position: BadgePosition.topEnd(top: 0, end: 0),
                child: Icon(
                  icon,
                  color: selected ? Colors.white : Colors.grey.shade300,
                ))
            : Icon(
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
          if (canRoute) {
            callback?.call();

            if (routeGen != null) {
              final route = routeGen!.call();
              if (route.isNotEmpty) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    route, ModalRoute.withName(Routes.home));
              }
            }
          }
        },
      ),
    );
  }
}
