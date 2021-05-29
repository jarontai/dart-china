part of 'widgets.dart';

Widget buildSliverTopicList(BuildContext context) {
  return BlocBuilder<TopicListCubit, TopicListState>(builder: (_, state) {
    if (state is TopicListSuccess && !state.loading) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            return Container(
              decoration: BoxDecoration(
                color: ColorPalette.topicBgColor,
                boxShadow: [
                  BoxShadow(
                    color: ColorPalette.topicCardColor,
                    blurRadius: 0,
                    spreadRadius: 0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: index >= state.topics.length
                  ? ListLoader()
                  : TopicCard(
                      topic: state.topics[index],
                    ),
            );
          },
          childCount:
              state.more ? state.topics.length + 1 : state.topics.length,
        ),
      );
    } else {
      return SliverFillRemaining(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: ColorPalette.topicBgColor,
            boxShadow: [
              BoxShadow(
                color: ColorPalette.topicCardColor,
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
              Navigator.of(context).pushNamed(Routes.topic, arguments: topic);
            },
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(Routes.topic, arguments: topic);
              },
              child: PostBody(content: topic.excerpt!),
            ),
          ),
          SizedBox(height: 8),
          TopicStatus(
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

class TopicStatus extends StatelessWidget {
  const TopicStatus({
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
