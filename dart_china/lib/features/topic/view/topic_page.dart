// import 'package:dart_china/features/topic/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dart_china/features/topic/cubit/topic_cubit.dart';
import 'package:dart_china/widgets/widgets.dart';

class TopicPage extends StatelessWidget {
  const TopicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('查看主题'),
      ),
    );
  }
}

class OldTopicPage extends StatefulWidget {
  OldTopicPage({
    Key? key,
    required this.topicId,
  }) : super(key: key);

  static final String routeName = '/topic';
  final int topicId;

  @override
  _OldTopicPageState createState() => _OldTopicPageState();
}

class _OldTopicPageState extends State<OldTopicPage> {
  @override
  void initState() {
    BlocProvider.of<TopicCubit>(context).fetchTopic(widget.topicId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TopicCubit, TopicState>(
        builder: (context, state) {
          switch (state.status) {
            case TopicStatus.initial:
              TODO:
              break;
            case TopicStatus.success:
              return Container(
                child: Column(
                  children: [
                    TopicPostHead(
                      topic: state.topic!,
                      onAvatarPressed: () {
                        print('avatar pressed');
                      },
                    ),
                  ],
                ),
              );
          }
          return Container();
        },
      ),
    );
  }
}

// class TopicPostList extends StatelessWidget {
//   const TopicPostList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: BlocBuilder<TopicCubit, TopicState>(
//         builder: (context, state) {
//           if (state.status == TopicStatus.initial) {
//             return ListLoader();
//           } else {
//             return ListView.builder(
//               itemBuilder: (_, index) {
//                 if (index >= state.posts.length) {
//                   return ListLoader();
//                 }

//                 var posts = state.posts;
//                 if (posts.isNotEmpty) {
//                   return Container(
//                     child: Text(posts[index].cooked),
//                   );
//                 } else {
//                   return ListLoader();
//                 }
//               },
//               itemCount:
//                   state.more ? state.posts.length + 1 : state.posts.length,
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class TopicDetailCard extends StatelessWidget {
//   const TopicDetailCard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       child: Column(
//         children: [],
//       ),
//     );
//   }
// }

class TopicPostHead extends StatelessWidget {
  const TopicPostHead({
    Key? key,
    required this.topic,
    required this.onAvatarPressed,
  }) : super(key: key);

  final Topic topic;
  final VoidCallback onAvatarPressed;

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
          ClipOval(
            child: IconButton(
              onPressed: onAvatarPressed,
              icon: CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                radius: 25,
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
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all(Colors.grey.shade100),
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
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
