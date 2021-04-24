import 'package:flutter/material.dart';

import '../../../widgets/button.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 8,
      ),
      padding: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dart China',
                      style: TextStyle(
                        color: Colors.grey.shade100,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(left: 5),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          'assets/icon/logo_dart.png',
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '由爱好者建立，讨论 Dart、Flutter 的开放型技术社区',
                  style: TextStyle(
                    color: Color(0xFFadbcdf),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox.expand(),
          Column(
            children: [
              IconButton(
                iconSize: 30,
                color: Colors.grey.shade300,
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}

class TopicSection extends StatelessWidget {
  const TopicSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF1F6FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Center(
        child: Button(
          text: '最新',
          onPressed: () {},
          pressed: false,
        ),
      ),
    );
  }
}
