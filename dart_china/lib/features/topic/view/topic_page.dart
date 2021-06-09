import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../common.dart';
import '../../../widgets/widgets.dart';
import '../../global/cubit/global_cubit.dart';
import '../cubit/topic_cubit.dart';
import 'widgets/widgets.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({
    Key? key,
    required this.topicId,
  }) : super(key: key);

  final int topicId;

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    context.read<TopicCubit>().fetchTopic(widget.topicId);

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
      body: BlocConsumer<TopicCubit, TopicState>(
        listener: (context, state) {
          if (state.postSuccess) {
            EasyLoading.showToast('帖子发布成功');
          }
        },
        builder: (context, state) {
          if (state.status == TopicStatus.success) {
            var topic = state.topic!;
            var postCount = state.posts.length;
            var itemCount = postCount;
            if (state.loading) {
              itemCount += 1;
            }
            return _buildPostList(topic, postCount, itemCount, state);
          } else {
            return ListLoader();
          }
        },
      ),
    );
  }

  Widget _buildPostButton(BuildContext context) {
    var appState = context.read<GlobalCubit>().state;
    return ReplySection(
      canOpen: appState.userLogin,
      onReject: () {
        Navigator.of(context).pushNamed(Routes.login);
      },
      onReply: (text) {
        var topicCubit = context.read<TopicCubit>();
        topicCubit.createTopicPost(text);
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
        top: 10,
        left: 20,
        right: 20,
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
