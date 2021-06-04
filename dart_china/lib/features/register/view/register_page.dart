import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/register_cubit.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Login'),
      ),
      body: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          Widget child = CircularProgressIndicator();
          if (state.initialUrl.isNotEmpty) {}
          return SafeArea(
            child: Container(
              child: child,
            ),
          );
        },
      ),
    );
  }
}
