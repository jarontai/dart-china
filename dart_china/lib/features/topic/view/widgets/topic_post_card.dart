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
        decoration: BoxDecoration(
          color: kTopicCardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              children: [
                AvatarButton(
                  onPressed: () {},
                  avatarUrl: topic.users!.first.avatar,
                )
              ],
            )
          ],
        ));
  }
}
