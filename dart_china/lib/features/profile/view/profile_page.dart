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
    return Scaffold(
      backgroundColor: ColorPalette.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorPalette.backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ProfileCard(
              onPickAvatar: (file) {
                context.read<ProfileCubit>().updateAvatar(2, 'jarontai', file);
              },
            )
          ],
        ),
      ),
    );
  }
}
