import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'package:dart_china/common.dart';
import 'package:dart_china/features/profile/cubit/profile_cubit.dart';
import 'package:dart_china/features/profile/view/widgets/widgets.dart';
import 'package:dart_china/models/models.dart';

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

    context.read<ProfileCubit>().init(widget.username);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: ColorPalette.backgroundColor,
        appBar: AppBar(
          backgroundColor: ColorPalette.backgroundColor,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              final myState = state;
              User? user;
              if (myState is ProfileSuccess) {
                user = myState.user;
              }

              return Column(
                children: [
                  _buildHead(context, user),
                  _buildBody(context, user),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHead(BuildContext context, User? user) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditableAvatar(
            avatar: user?.avatar ?? '',
            onPickAvatar: (file) {
              if (user != null) {
                context
                    .read<ProfileCubit>()
                    .updateAvatar(user.id, user.username, file);
              }
            },
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            user?.username ?? '',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
      padding: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white38),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, User? user) {
    final summary = user?.summary;

    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            user?.bio ?? '',
            style: TextStyle(
              color: Colors.grey.shade100,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          height: 80,
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
                number: '${(summary?.timeRead ?? 0) ~/ (60)}',
                text: '阅读分钟',
                rightBorder: true,
              ),
              _StatisticItem(
                number: '${summary?.topicsEntered ?? 0}',
                text: '已阅主题',
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              _StatisticItem(
                number: '${summary?.postsReadCount ?? 0}',
                text: '已读帖子',
                rightBorder: true,
              ),
              _StatisticItem(
                number: '${summary?.topicCount ?? 0}',
                text: '发表主题',
                rightBorder: true,
              ),
              _StatisticItem(
                number: '${summary?.postCount ?? 0}',
                text: '发表帖子',
              ),
            ],
          ),
        ),
      ],
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
                fontSize: 20,
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
