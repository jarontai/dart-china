import 'package:flutter/material.dart';

import '../models.dart';
import 'avatar_button.dart';

class TopicPostHeader extends StatelessWidget {
  const TopicPostHeader({
    Key? key,
    this.topicHead = true,
    required this.topic,
    required this.onAvatarPressed,
    required this.onTitlePressed,
  }) : super(key: key);

  final Topic topic;
  final bool topicHead;
  final VoidCallback onAvatarPressed;
  final VoidCallback onTitlePressed;

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

  @override
  Widget build(BuildContext context) {
    var pin = topic.pinnedGlobally;
    var avatar = topic.poster?.avatar;
    var username = topic.poster?.username;

    var titleColor;
    var title;
    var subTitle;
    if (topicHead) {
      titleColor = Colors.black87;
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
                  TextButton(
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.grey.shade100),
                    ),
                    onPressed: onTitlePressed,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: titleColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
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
            child: IconButton(
              icon: Icon(
                Icons.push_pin_outlined,
                color: pin ? Color(0xFFB0B1BA) : Colors.transparent,
                size: 20,
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
