import 'package:dart_china/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../commons.dart';
import '../cubit/topic_cubit.dart';
import 'widgets/widgets.dart';

class TopicPage extends StatefulWidget {
  static final routeName = '/topic';

  const TopicPage({
    Key? key,
    required this.topic,
  }) : super(key: key);

  final Topic topic;

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  late TopicCubit _topicCubit;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _topicCubit = context.read<TopicCubit>();
    _topicCubit.fetchTopic(widget.topic);

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        var maxExtent = _scrollController.position.maxScrollExtent;
        if (_scrollController.offset >= (maxExtent * 0.9) &&
            !_scrollController.position.outOfRange) {
          context.read<TopicCubit>().fetchTopicPosts();
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTopicBgColor,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          '查看话题',
          style: TextStyle(color: kTitleColor),
        ),
        backgroundColor: kTopicBgColor,
        elevation: 0,
        iconTheme: IconThemeData(color: kTitleColor),
      ),
      body: BlocBuilder<TopicCubit, TopicState>(
        builder: (_, state) {
          if (state.status == TopicStatus.success) {
            var topic = state.topic!;
            var postCount = state.posts.length;
            var itemCount = postCount;
            if (state.loading) {
              itemCount += 1;
            }
            var enableSend = state.status != TopicStatus.posting;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: 5,
                  left: 20,
                  right: 20,
                ),
                child: Stack(
                  children: [
                    _buildPostList(topic, postCount, itemCount, state),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ReplySection(
                        enableSend: enableSend,
                        onSubmit: (data) {
                          context
                              .read<TopicCubit>()
                              .createTopicPost(topic.id, data);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return ListLoader();
          }
        },
      ),
    );
  }

  Container _buildPostList(
      Topic topic, int postCount, int itemCount, TopicState state) {
    return Container(
      padding: EdgeInsets.only(
        top: 5,
      ),
      child: ListView.separated(
        controller: _scrollController,
        itemBuilder: (_, index) {
          if (index >= postCount) {
            return ListLoader();
          }
          return TopicPostCard(
            topic: topic,
            post: state.posts[index],
            topicPost: index == 0,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              padding: EdgeInsets.only(top: 20, left: 10),
              height: 50,
              color: kTopicBgColor,
              child: Text(
                '回复（${topic.postsCount})',
                style: TextStyle(
                  color: kTitleColor,
                  fontSize: 16,
                ),
              ),
            );
          } else {
            return Divider(
              color: kTopicBgColor,
            );
          }
        },
        itemCount: itemCount,
      ),
    );
  }
}
