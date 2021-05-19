import 'package:dart_china/commons.dart';
import 'package:dart_china/widgets/button_widget.dart';
import 'package:dart_china/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static final String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: ColorPalette.backgroundColor,
          child: Column(
            children: [
              _buildHead(),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHead() {
    return Container(
      color: ColorPalette.backgroundColor,
      width: double.infinity,
      padding: EdgeInsets.only(top: 55, bottom: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 28,
            child: Image.asset(
              'assets/icon/logo_dart.png',
              height: 40,
              width: 40,
            ),
          ),
          SizedBox(height: 40),
          Text(
            '欢迎回到 Dart China',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          InputWidget(
            label: '用户名',
          ),
          SizedBox(
            height: 15,
          ),
          InputWidget(
            label: '密码',
            obscure: true,
          ),
          SizedBox(height: 45),
          ButtonWidget(
            text: '登录',
            onPressed: () {
              print('pressed login');
            },
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: Text('注册新账号'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
