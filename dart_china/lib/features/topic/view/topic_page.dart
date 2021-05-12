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

  @override
  void initState() {
    super.initState();
    _topicCubit = context.read<TopicCubit>();
    _topicCubit.fetchTopic(widget.topic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kTopicBgColor,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          '查看话题',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: kTopicBgColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<TopicCubit, TopicState>(
        builder: (_, state) {
          if (state.status == TopicStatus.success) {
            var topic = state.topic!;
            return ListView(
              children: [
                TopicPostCard(
                  topic: topic,
                )
              ],
            );
          } else {
            return ListLoader();
          }
        },
      ),
    );
  }
}
