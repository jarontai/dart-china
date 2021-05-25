import 'package:dart_china/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  Widget _buildHeader() {
    return Container(
      child: Row(
        children: [
          AvatarButton(
            avatarUrl: '',
            onPressed: () {},
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
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildBody(),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
