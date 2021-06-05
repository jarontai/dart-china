import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
  final form = FormGroup({
    'username': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          color: ColorPalette.backgroundColor,
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if ((state.isLogin || state.fail) && state.message.isNotEmpty) {
                FocusManager.instance.primaryFocus?.unfocus();
                Fluttertoast.showToast(
                    msg: state.message, gravity: ToastGravity.CENTER);
              }
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
      child: ReactiveForm(
        formGroup: this.form,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            InputWidget(
              name: 'username',
              label: '用户名',
              messages: {
                ValidationMessage.required: '用户名不能为空',
              },
            ),
            SizedBox(
              height: 15,
            ),
            InputWidget(
              name: 'password',
              label: '密码',
              messages: {
                ValidationMessage.required: '密码不能为空',
              },
              obscure: true,
              inputAction: TextInputAction.done,
            ),
            SizedBox(height: 45),
            ButtonWidget(
              text: '登录',
              onPressed: () {
                if (form.valid) {
                  var username = form.control('username').value;
                  var password = form.control('password').value;
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
