import 'package:dart_china/commons.dart';
import 'package:flutter/material.dart';

class AvatarButton extends StatelessWidget {
  const AvatarButton({
    Key? key,
    this.size = 24,
    this.onPressed,
    required this.avatarUrl,
  }) : super(key: key);

  final double size;
  final VoidCallback? onPressed;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: IconButton(
        iconSize: size,
        onPressed: onPressed,
        icon: CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          radius: 25,
          child: ClipOval(
            child: avatarUrl != null && avatarUrl!.isNotEmpty
                ? Image.network(
                    avatarUrl!,
                    fit: BoxFit.fitWidth,
                    width: size + 10,
                    height: size + 10,
                  )
                : Icon(
                    Icons.person,
                    color: ColorPalette.postTextColor,
                  ),
          ),
        ),
      ),
    );
  }
}
