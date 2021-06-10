import 'package:dart_china/common.dart';
import 'package:dart_china/features/profile/cubit/profile_cubit.dart';
import 'package:dart_china/features/profile/view/widgets/widgets.dart';
import 'package:dart_china/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          padding: EdgeInsets.all(15),
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
            height: 5,
          ),
          Text(
            user?.username ?? '',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.w500,
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
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                '1',
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                '1',
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                '1',
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white30,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                  child: Text(
                '1',
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                '1',
                textAlign: TextAlign.center,
              )),
              Expanded(
                  child: Text(
                '1',
                textAlign: TextAlign.center,
              )),
            ],
          ),
        ),
      ],
    );
  }
}
