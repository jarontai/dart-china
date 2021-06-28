import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common.dart';
import '../../../models/models.dart';
import '../../../widgets/widgets.dart';
import '../bloc/profile_bloc.dart';
import 'widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    context.read<ProfileBloc>().add(ProfileInit(username: widget.username));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ColorPalette.backgroundColor,
        appBar: AppBar(
          title: Text(
            '我的',
          ),
          backgroundColor: ColorPalette.backgroundColor,
          elevation: 0,
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final myState = state;
            User? user;
            List<Topic>? topics;
            if (myState is ProfileSuccess) {
              user = myState.user;
              topics = myState.recentTopics;
            }

            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    _buildHead(context, user),
                    _buildBody(context, user),
                  ]),
                ),
                SizedBox(
                  height: 25,
                ),
                _buildFooter(context, topics),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHead(BuildContext context, User? user) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white38),
        ),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditableAvatar(
            avatar: user?.avatar ?? '',
            onPickAvatar: (file) {
              if (user != null) {
                // TODO: updateAvatar
                // context
                //     .read<ProfileBloc>()
                //     .updateAvatar(user.id, user.username, file);
              }
            },
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            user?.username ?? '',
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, User? user) {
    final summary = user?.summary;

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            user?.bio ?? '',
            style: TextStyle(
              color: Colors.grey.shade100,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          height: 0,
        ),
        Container(
          height: 65,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              _StatisticItem(
                number: '${summary?.daysVisited ?? 0}',
                text: '访问天数',
                rightBorder: true,
              ),
              _StatisticItem(
                number: '${summary?.topicCount ?? 0}',
                text: '发表主题',
                rightBorder: true,
              ),
              _StatisticItem(
                number: '${summary?.postsReadCount ?? 0}',
                text: '已读帖子',
              ),
            ],
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        // Container(
        //   height: 80,
        //   decoration: BoxDecoration(
        //     color: Colors.white24,
        //     borderRadius: BorderRadius.circular(15),
        //   ),
        //   child: Row(
        //     children: [
        //       _StatisticItem(
        //         number: '${summary?.postsReadCount ?? 0}',
        //         text: '已读帖子',
        //         rightBorder: true,
        //       ),
        //       _StatisticItem(
        //         number: '${summary?.topicCount ?? 0}',
        //         text: '发表主题',
        //         rightBorder: true,
        //       ),
        //       _StatisticItem(
        //         number: '${summary?.postCount ?? 0}',
        //         text: '发表帖子',
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context, List<Topic>? topics) {
    var topicCards = <Widget>[];
    if (topics != null && topics.isNotEmpty) {
      topicCards.addAll(topics.map((e) => TopicCard(topic: e)));
    }

    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          top: 15,
        ),
        decoration: BoxDecoration(
          color: ColorPalette.topicBgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Text(
                  '最近阅读主题',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Expanded(
              child: ListView(
                children: topicCards,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatisticItem extends StatelessWidget {
  const _StatisticItem({
    Key? key,
    this.number = '-',
    this.text = '',
    this.rightBorder = false,
  }) : super(key: key);

  final String number;
  final String text;
  final bool rightBorder;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: rightBorder
              ? Border(right: BorderSide(color: Colors.white38))
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              number.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 2,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            )
          ],
        ),
      ),
    );
  }
}
