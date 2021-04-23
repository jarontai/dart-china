import 'package:dart_china/constants.dart';
import 'package:flutter/material.dart';

class TopicListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: kMainGradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(),
        body: SafeArea(
            child: Column(
          children: [
            WelcomeSection(),
          ],
        )),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: ClipOval(
            child: CircleAvatar(
              backgroundColor: kTagColr,
              child: Image.asset(
                'assets/icon/logo_dart.png',
                width: 25,
              ),
            ),
          ),
          onPressed: () {},
        )
      ],
    );
  }
}

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
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
                Text(
                  'Dart China',
                  style: TextStyle(
                    color: Colors.grey.shade100,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '由爱好者建立，讨论 Dart、Flutter 的开放型中文社区',
                  style: TextStyle(
                    color: Color(0xFFadbcdf),
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
