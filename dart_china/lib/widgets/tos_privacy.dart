import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../common.dart';

class TosPrivacy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: '服务条款',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed(Routes.tos);
                    }),
              TextSpan(text: '和', style: TextStyle(color: Colors.black)),
              TextSpan(
                  text: '隐私政策',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).pushNamed(Routes.privacy);
                    }),
            ]),
          ),
          Expanded(
            child: SizedBox.shrink(),
          ),
          TextButton(
            child: Text(
              '注册新账号',
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.register);
            },
          ),
        ],
      ),
    );
  }
}
