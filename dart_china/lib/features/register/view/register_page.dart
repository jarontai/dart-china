import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../commons.dart';
import '../../../widgets/button_widget.dart';
import '../../../widgets/widgets.dart';
import '../cubit/register_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: ColorPalette.backgroundColor,
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              // if (state.isLogin) {
              //   Navigator.of(context).pushNamed(Routes.home);
              // }
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
            '欢迎注册 Dart China',
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
              label: '邮箱',
              controller: _emailController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '邮箱不能为空';
                }
                if (!RegExps.email.hasMatch(value)) {
                  return '邮箱格式错误';
                }
              },
            ),
            SizedBox(
              height: 15,
            ),
            InputWidget(
              label: '用户名',
              controller: _usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '用户名不能为空';
                }
                if (value.length < 3) {
                  return '用户名小长不能小于3';
                }
                if (!RegExps.username.hasMatch(value)) {
                  return '用户名只能使用数字、字母、下划线';
                }
              },
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
                if (value.length < 10) {
                  return '密码长度不能小于10';
                }
              },
              inputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 15,
            ),
            InputWidget(
              label: '密码确认',
              obscure: true,
              controller: _passwordConfirmController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '密码不能为空';
                }
                if (value != _passwordController.value) {
                  return '密码不一致';
                }
              },
              inputAction: TextInputAction.done,
            ),
            SizedBox(height: 45),
            ButtonWidget(
              text: '注册',
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  var username = _usernameController.text;
                  var password = _passwordController.text;
                  // context.read<RegisterCubit>().login(username, password);
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
