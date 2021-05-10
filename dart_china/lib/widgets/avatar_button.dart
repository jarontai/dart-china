import 'package:flutter/material.dart';

class AvatarButton extends StatelessWidget {
  const AvatarButton({
    Key? key,
    required this.onPressed,
    required this.avatarUrl,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: IconButton(
        onPressed: onPressed,
        icon: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          radius: 25,
          child: ClipOval(
            child: avatarUrl != null && avatarUrl!.isNotEmpty
                ? Image.network(
                    avatarUrl!,
                    fit: BoxFit.fitWidth,
                    width: 35,
                    height: 35,
                  )
                : Image.asset(
                    'assets/icon/logo_dart_ios.png',
                    fit: BoxFit.fitWidth,
                    width: 35,
                    height: 35,
                  ),
          ),
        ),
      ),
    );
  }
}
