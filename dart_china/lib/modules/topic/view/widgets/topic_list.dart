part of 'widgets.dart';

class TopicList extends StatelessWidget {
  const TopicList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TopicCard(),
    );
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
                    fontWeight: FontWeight.w400,
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
