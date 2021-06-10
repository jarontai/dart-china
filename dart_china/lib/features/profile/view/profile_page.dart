import 'package:dart_china/common.dart';
import 'package:dart_china/features/profile/cubit/profile_cubit.dart';
import 'package:dart_china/features/profile/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final int? userId;

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
          child: Column(
            children: [
              _buildHead(context),
              _buildBody(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHead(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EditableAvatar(
            avatar: '',
            onPickAvatar: (file) {
              context.read<ProfileCubit>().updateAvatar(2, 'jarontai', file);
            },
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Jaron Tai',
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

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Woooooj, odddddddd,dd,d,,d,d,d,d,d,d,d,f,f,f,f,f,f,f',
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
          height: 25,
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
