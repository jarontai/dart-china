import 'package:dart_china/features/app/cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dart_china/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  Widget _buildHeader({String? avatar, String? username}) {
    return Container(
      child: Row(
        children: [
          AvatarButton(
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

  Widget _buildBody() {
    return Container();
  }

  Widget _buildFooter() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppCubit b) => b.state.user);

    return Scaffold(
      backgroundColor: Color(0xFF657599),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 20,
          ),
          child: Column(
            children: [
              _buildHeader(
                avatar: user?.avatar,
                username: user?.username,
              ),
              _buildBody(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
