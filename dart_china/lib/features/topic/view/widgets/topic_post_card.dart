part of 'widgets.dart';

const userAvatar = 'user_avatar';

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
        color: ColorPalette.topicCardColor,
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
                  height: 1.5,
                  fontSize: 15,
                ),
                blockquoteDecoration: BoxDecoration(
                  color: Color(0xFFedf1fa),
                  borderRadius: BorderRadius.circular(5),
                ),
                // blockquotePadding: EdgeInsets.zero,
              ),
              imageBuilder: _buildImageBuilder,
              onTapLink: (text, href, title) async {
                if (href != null && href.startsWith('http')) {
                  var can = await urlLauncher.canLaunch(href);
                  if (can) {
                    await urlLauncher.launch(href);
                  } else {
                    // TODO: ?
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageBuilder(Uri uri, String? title, String? alt) {
    if (uri.path.contains(userAvatar)) {
      return CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        child: ClipOval(
          child: Image.network(
            uri.toString(),
            fit: BoxFit.fitWidth,
            width: 25,
            height: 25,
          ),
        ),
      );
    } else {
      return Image.network(uri.toString());
    }
  }
}
