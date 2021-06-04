import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../commons.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/widgets.dart';
import '../cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: ColorPalette.backgroundColor,
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.isLogin) {
                Navigator.of(context).pushNamed(Routes.home);
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  _buildHead(),
                  _buildForm(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHead() {
    return Container(
      color: ColorPalette.backgroundColor,
      width: double.infinity,
      padding: EdgeInsets.only(top: 60, bottom: 15),
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
          SizedBox(height: 20),
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
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            InputWidget(
              label: '用户名',
              controller: _usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '用户名不能为空';
                }
              },
              // inputAction: TextInputAction.continueAction,
            ),
            SizedBox(
              height: 15,
            ),
            InputWidget(
              label: '密码',
              obscure: true,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '密码不能为空';
                }
              },
              inputAction: TextInputAction.done,
            ),
            SizedBox(height: 45),
            ButtonWidget(
              text: '登录',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var username = _usernameController.text;
                  var password = _passwordController.text;
                  context.read<LoginCubit>().login(username, password);
                } else {}
              },
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text('注册新账号'),
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.register);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
