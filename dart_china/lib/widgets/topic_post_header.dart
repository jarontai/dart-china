import 'package:flutter/material.dart';

import '../commons.dart';
import '../models/models.dart';
import 'avatar_button.dart';

class TopicPostHeader extends StatelessWidget {
  const TopicPostHeader({
    Key? key,
    this.topicHead = true,
    required this.topic,
    required this.post,
    required this.onAvatarPressed,
    required this.onTitlePressed,
  }) : super(key: key);

  final Topic topic;
  final Post? post;
  final bool topicHead;
  final VoidCallback onAvatarPressed;
  final VoidCallback onTitlePressed;

  @override
  Widget build(BuildContext context) {
    var pin = topicHead ? topic.pinnedGlobally : false;
    var avatar = topicHead ? topic.poster?.avatar : post!.avatar;
    var username = topicHead ? topic.poster?.username : post!.username;

    var titleColor;
    var title;
    var subTitle;
    if (topicHead) {
      titleColor = ColorPalette.titleColor;
      title = topic.title;
      subTitle = '$username • ${_buildCreatedAt(topic.createdAt)}';
    } else {
      titleColor = Colors.black54;
      subTitle = '${_buildCreatedAt(topic.createdAt)}';
      title = username;
    }

    return Container(
      child: Row(
        children: [
          AvatarButton(onPressed: onAvatarPressed, avatarUrl: avatar),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                    child: InkWell(
                      onTap: onTitlePressed,
                      child: Text(
                        title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: titleColor,
                          height: 1.2,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: topicHead ? 2 : 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    subTitle,
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: topicHead
                ? IconButton(
                    icon: Icon(
                      Icons.push_pin_outlined,
                      color: pin ? Color(0xFFB0B1BA) : Colors.transparent,
                      size: 20,
                    ),
                    onPressed: () {},
                  )
                : null,
          )
        ],
      ),
    );
  }

  String _buildCreatedAt(DateTime dateTime) {
    DateTime now = DateTime.now();
    var diff = now.difference(dateTime);
    var minutes = diff.inMinutes;
    if (minutes >= 1440) {
      return '${diff.inDays} 天前';
    } else if (minutes >= 60 && minutes < 1440) {
      return '${diff.inHours} 小时前';
    } else {
      return '$minutes 分钟前';
    }
  }
}
