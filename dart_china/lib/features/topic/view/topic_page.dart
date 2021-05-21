import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dart_china/features/app/cubit/app_cubit.dart';

import '../../../commons.dart';
import '../../../widgets/widgets.dart';
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
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

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
      backgroundColor: ColorPalette.topicBgColor,
      appBar: _buildAppBar(),
      floatingActionButton: _buildPostButton(context),
      body: BlocBuilder<TopicCubit, TopicState>(
        builder: (_, state) {
          if (state.status == TopicStatus.success) {
            var topic = state.topic!;
            var postCount = state.posts.length;
            var itemCount = postCount;
            if (state.loading) {
              itemCount += 1;
            }
            return Container(
              padding: EdgeInsets.only(
                top: 5,
                left: 20,
                right: 20,
              ),
              child: _buildPostList(topic, postCount, itemCount, state),
            );
          } else {
            return ListLoader();
          }
        },
      ),
    );
  }

  Widget _buildPostButton(BuildContext context) {
    var appState = context.read<AppCubit>().state;
    return ReplySection(
      canOpen: appState.userLogin,
      onReject: () {
        Navigator.of(context).pushNamed('/login');
      },
      onReply: (text) {
        // TODO:
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: false,
      title: Text(
        '查看话题',
        style: TextStyle(color: ColorPalette.titleColor),
      ),
      backgroundColor: ColorPalette.topicBgColor,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorPalette.titleColor),
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
              color: ColorPalette.topicBgColor,
              child: Text(
                '回复 (${topic.postsCount})',
                style: TextStyle(
                  color: ColorPalette.titleColor,
                  fontSize: 16,
                ),
              ),
            );
          } else {
            return Divider(
              color: ColorPalette.topicBgColor,
            );
          }
        },
        itemCount: itemCount,
      ),
    );
  }
}

class ReplySection extends StatefulWidget {
  const ReplySection({
    Key? key,
    this.canOpen = false,
    required this.onReject,
    required this.onReply,
  }) : super(key: key);

  final bool canOpen;
  final VoidCallback onReject;
  final StrDataCallback onReply;

  @override
  _ReplySectionState createState() => _ReplySectionState();
}

class _ReplySectionState extends State<ReplySection> {
  bool _open = false;
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          color: Colors.red,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                mini: true,
                backgroundColor: ColorPalette.backgroundColor,
                child: Icon(Icons.send),
                onPressed: () {
                  if (!widget.canOpen) {
                    widget.onReject();
                    return;
                  }

                  if (!_open) {
                    setState(() {
                      _open = true;
                    });
                  } else {
                    widget.onReply(_text);
                  }

                  // var topicCubit = context.read<TopicCubit>();
                  // var appState = context.read<AppCubit>().state;
                  // if (!appState.userLogin) {
                  //   topicCubit.togglePostReply(false);
                  //   Navigator.pushNamed(context, '/login');
                  // } else {
                  //   topicCubit.togglePostReply(true);
                  // }
                },
              )
            ],
          ),
        )
      ],
    );
  }

  FloatingActionButton _buildOpen(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      backgroundColor: ColorPalette.backgroundColor,
      child: Icon(Icons.send),
      onPressed: () {
        var topicCubit = context.read<TopicCubit>();
        var appState = context.read<AppCubit>().state;
        if (!appState.userLogin) {
          topicCubit.togglePostReply(false);
          Navigator.pushNamed(context, '/login');
        } else {
          topicCubit.togglePostReply(true);
        }
      },
    );
  }
}
