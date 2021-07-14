import 'package:dart_china/common.dart';
import 'package:dart_china/features/features.dart';
import 'package:dart_china/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于Dart China'),
        backgroundColor: ColorPalette.backgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            _buildHead(),
            Expanded(child: SizedBox.shrink()),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHead() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 70,
      ),
      child: Column(
        children: [
          SizedBox(
            child: Image.asset('assets/icon/logo_dart.png'),
            height: 60,
            width: 60,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Dart China',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<AboutBloc, AboutState>(
            builder: (context, state) {
              return Text(
                '当前版本：V${state.appVersion}',
                style: TextStyle(
                  color: Colors.grey,
                  // fontSize: 14,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Center(
        child: TosPrivacy(
      center: true,
    ));
  }
}
