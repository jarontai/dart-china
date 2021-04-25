part of 'widgets.dart';

class TopicList extends StatelessWidget {
  const TopicList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.separated(
      itemCount: 5,
      itemBuilder: (_, __) {
        return TopicCard();
      },
      separatorBuilder: (_, __) {
        return SizedBox(height: 18);
      },
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
    ));
  }
}

class TopicCard extends StatelessWidget {
  const TopicCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFFDFDFD),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          TopicCardHead(),
          TopicBody(
              content:
                  'So, i ve been using c# for a whhole decade now, if you guys know how to break the boring...'),
        ],
      ),
    );
  }
}

class TopicCardHead extends StatelessWidget {
  const TopicCardHead({Key? key}) : super(key: key);

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
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dart In A Nutshell',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Janu Ptura • 1小时前',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.bookmark_outline,
                    color: Color(0xFFB0B1BA),
                  ),
                  onPressed: () {},
                )
              ],
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
        style: TextStyle(
          color: Color(0xFF8E8E9F),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
