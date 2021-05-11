part of 'widgets.dart';

class TopicPostCard extends StatelessWidget {
  const TopicPostCard({
    Key? key,
    required this.topic,
  }) : super(key: key);

  final Topic topic;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        decoration: BoxDecoration(
          color: kTopicCardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TopicPostHeader(
          topicHead: false,
          topic: topic,
          onAvatarPressed: () {},
          onTitlePressed: () {},
        ));
  }
}
