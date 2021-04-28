part of 'widgets.dart';

Widget buildSliverTopicList(BuildContext context) {
  return BlocBuilder<TopicCubit, TopicState>(builder: (_, state) {
    if (state is TopicSuccess) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
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
                  title: state.topics[index].title,
                  body: state.topics[index].title),
            );
          },
          childCount: state.topics.length,
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
  const TopicCard({Key? key, required this.title, required this.body})
      : super(key: key);

  final String title;
  final String body;

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
            title: title,
          ),
          TopicBody(content: body),
          SizedBox(height: 8),
          TopicStatus(),
        ],
      ),
    );
  }
}

class TopicStatus extends StatelessWidget {
  const TopicStatus({
    Key? key,
  }) : super(key: key);

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
                  color: Color(0xFF40a37e),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              SizedBox(width: 5),
              Text(
                '分享',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFFB0B1BA),
                  height: 1,
                ),
              ),
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
                '120',
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
                '120',
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
                '120',
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
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.asset(
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
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    'Janu Ptura • 1小时前',
                    style: TextStyle(
                      color: Colors.grey.shade400,
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
                Icons.bookmark_outline,
                color: Color(0xFFB0B1BA),
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
