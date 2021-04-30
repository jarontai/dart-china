part of 'widgets.dart';

Widget buildSliverTopicList(BuildContext context) {
  return BlocBuilder<TopicCubit, TopicState>(builder: (_, state) {
    if (state is TopicSuccess) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            var topic = state.topics[index];
            return Container(
              decoration: BoxDecoration(
                color: Color(0xFFF1F6FA),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFDFDFD),
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TopicCard(
                topic: topic,
              ),
            );
          },
          childCount: state.topics.length,
        ),
      );
    } else if (state is TopicInitial) {
      return SliverFillRemaining(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: Color(0xFFF1F6FA),
            boxShadow: [
              BoxShadow(
                color: Color(0xFFFDFDFD),
                blurRadius: 0,
                spreadRadius: 0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
  });
}

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
        color: Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          TopicCardHead(
            topic: topic,
          ),
          TopicBody(content: topic.excerpt!),
          SizedBox(height: 8),
          TopicStatus(
            slug: topic.categorySlug!,
            view: topic.views,
            reply: topic.replyCount,
            like: topic.likeCount,
          ),
        ],
      ),
    );
  }
}

class TopicStatus extends StatelessWidget {
  const TopicStatus({
    Key? key,
    this.slug = '',
    this.view = 0,
    this.reply = 0,
    this.like = 0,
  }) : super(key: key);

  final String slug;
  final int view;
  final int reply;
  final int like;

  Text buildType() {
    var type = '其他';
    switch (slug) {
      case 'share':
        type = '分享';
        break;
      case 'question':
        type = '问答';

        break;
      case 'meta':
        type = '站务';

        break;
    }

    return Text(
      type,
      style: TextStyle(
        fontSize: 11,
        color: Colors.grey.shade500,
        height: 1,
      ),
    );
  }

  Color buildColor() {
    var color = Color(0xFFB0B1BA);
    switch (slug) {
      case 'share':
        color = Color(0xFF40a37e);
        break;
      case 'question':
        color = Color(0xFFd9a01c);

        break;
      case 'meta':
        color = Color(0xFFa19b8f);

        break;
    }
    return color;
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
              SizedBox(width: 50),
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
                '$reply',
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

class TopicCardHead extends StatelessWidget {
  const TopicCardHead({
    Key? key,
    required this.topic,
  }) : super(key: key);

  final Topic topic;

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
    var title = topic.title;
    var pin = topic.pinnedGlobally;
    var avatar = topic.poster?.avatar;
    var username = topic.poster?.username;

    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: avatar != null
                  ? Image.network(
                      avatar,
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
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                left: 8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    '$username • ${_buildCreatedAt(topic.createdAt)}',
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

class TopicBody extends StatelessWidget {
  const TopicBody({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Text(
        content,
        textAlign: TextAlign.start,
        style: TextStyle(
          color: Color(0xFF8E8E9F),
          fontWeight: FontWeight.w500,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
