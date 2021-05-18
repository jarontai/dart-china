import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static final String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('login'),
      ),
    );
  }
}
