part of 'widgets.dart';

class TopicPostCard extends StatelessWidget {
  const TopicPostCard({
    Key? key,
    required this.topic,
    required this.post,
    this.topicPost = false,
  }) : super(key: key);

  final Topic topic;
  final Post post;
  final bool topicPost;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: kTopicCardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            TopicPostHeader(
              topicHead: false,
              topic: topic,
              post: post,
              onAvatarPressed: () {},
              onTitlePressed: () {},
            ),
            topicPost
                ? Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      topic.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 15,
              ),
              alignment: Alignment.centerLeft,
              child: MarkdownBody(
                data: post.markdown!,
                styleSheet: MarkdownStyleSheet(
                  textAlign: WrapAlignment.start,
                  p: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
