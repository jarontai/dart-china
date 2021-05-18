import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static final String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Column(
            children: [
              Text('欢迎回到DartChina'),
              SizedBox(height: 40),
              Image.asset('assets/icon/logo_dart_ios.png'),
            ],
          ),
          Container(),
        ],
      ),
    );
  }
}
