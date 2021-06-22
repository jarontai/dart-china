import 'package:flutter/material.dart';

import '../common.dart';
import '../models/models.dart';
import 'post_body.dart';
import 'topic_post_header.dart';

class TopicCard extends StatelessWidget {
  const TopicCard({
    Key? key,
    required this.topic,
  }) : super(key: key);

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: 10,
      ),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: ColorPalette.topicCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          TopicPostHeader(
            topic: topic,
            post: topic.posts?.first,
            onAvatarPressed: () {},
            onTitlePressed: () {
              Navigator.of(context)
                  .pushNamed(Routes.topic, arguments: topic.id);
            },
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(Routes.topic, arguments: topic.id);
              },
              child: PostBody(content: topic.excerpt!),
            ),
          ),
          SizedBox(height: 8),
          _TopicStatus(
            slug: topic.categorySlug!,
            view: topic.views,
            posts: topic.postsCount,
            like: topic.likeCount,
          ),
        ],
      ),
    );
  }
}

class _TopicStatus extends StatelessWidget {
  const _TopicStatus({
    Key? key,
    this.slug = '',
    this.view = 0,
    this.posts = 0,
    this.like = 0,
  }) : super(key: key);

  final String slug;
  final int view;
  final int posts;
  final int like;

  Text buildType() {
    return Text(
      CategoryNameMap[slug] ?? '其他',
      style: TextStyle(
        fontSize: 11,
        color: Colors.grey.shade500,
        height: 1,
      ),
    );
  }

  Color buildColor() {
    var color = Color(0xFFB0B1BA);
    return CategoryColorMap[slug] ?? color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: buildColor(),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              SizedBox(width: 5),
              buildType(),
              SizedBox(width: 75),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.visibility_outlined,
                color: Color(0xFFB0B1BA),
                size: 14,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '$view',
                style: TextStyle(
                  color: Color(0xFFB0B1BA),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.chat_bubble_outline,
                color: Color(0xFFB0B1BA),
                size: 14,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '$posts',
                style: TextStyle(
                  color: Color(0xFFB0B1BA),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.thumb_up_outlined,
                color: Color(0xFFB0B1BA),
                size: 14,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                '$like',
                style: TextStyle(
                  color: Color(0xFFB0B1BA),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
