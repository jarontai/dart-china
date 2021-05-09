// import 'package:dart_china/features/topic/view/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dart_china/features/topic/cubit/topic_cubit.dart';
import 'package:dart_china/widgets/widgets.dart';

class TopicPage extends StatefulWidget {
  TopicPage({
    Key? key,
    required this.topicId,
  }) : super(key: key);

  static final String routeName = '/topic';
  final int topicId;

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  @override
  void initState() {
    BlocProvider.of<TopicCubit>(context).fetchTopic(widget.topicId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}

class TopicDetail extends StatelessWidget {
  const TopicDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<TopicCubit, TopicState>(
        builder: (context, state) {
          if (state.status == TopicStatus.initial) {
            return ListLoader();
          } else {
            return ListView.builder(
              itemBuilder: (_, index) {
                if (index >= state.posts.length) {
                  return ListLoader();
                }

                var posts = state.posts;
                if (posts.isNotEmpty) {
                  return Container(
                    child: Text(posts[index].cooked),
                  );
                } else {
                  return ListLoader();
                }
              },
              itemCount:
                  state.more ? state.posts.length + 1 : state.posts.length,
            );
          }
        },
      ),
    );
  }
}
