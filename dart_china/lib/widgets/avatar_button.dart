import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../common.dart';

class AvatarButton extends StatelessWidget {
  const AvatarButton({
    Key? key,
    this.size = 35,
    this.onPressed,
    required this.avatarUrl,
  }) : super(key: key);

  final double size;
  final VoidCallback? onPressed;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.only(right: 8),
      iconSize: size,
      onPressed: onPressed,
      icon: CircleAvatar(
        radius: size / 2,
        backgroundColor: Colors.grey.shade200,
        child: ClipOval(
          child: avatarUrl != null && avatarUrl!.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: avatarUrl!,
                  fit: BoxFit.fitWidth,
                )
              : Icon(
                  Icons.person,
                  size: size * 0.6,
                  color: ColorPalette.postTextColor,
                ),
        ),
      ),
    );
  }
}
