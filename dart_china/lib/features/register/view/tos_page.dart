import 'package:dart_china/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../common.dart';

class TosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.topicBgColor,
      appBar: AppBar(
        title: Text(
          '服务条款',
        ),
        backgroundColor: ColorPalette.backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 15),
            child: FutureBuilder<String>(
              future: rootBundle.loadString('assets/text/tos.txt'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Text(snapshot.data ?? '资源加载错误'),
                  );
                }
                return Center(
                  child: ListLoader(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
