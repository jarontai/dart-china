import 'package:dart_china/commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/topic_list_cubit.dart';
import 'widgets/widgets.dart';

class TopicListPage extends StatefulWidget {
  @override
  _TopicListPageState createState() => _TopicListPageState();
}

class _TopicListPageState extends State<TopicListPage> {
  late ScrollController _scrollController;
  bool scrollToTop = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        var maxExtent = _scrollController.position.maxScrollExtent;
        if (_scrollController.offset >= (maxExtent * 0.9) &&
            !_scrollController.position.outOfRange) {
          BlocProvider.of<TopicListCubit>(context).fetchLatest();
        }

        var shouldScrollTop = false;
        if (_scrollController.offset >= (maxExtent * 0.1) &&
            !_scrollController.position.outOfRange) {
          shouldScrollTop = true;
        }
        setState(() {
          scrollToTop = shouldScrollTop;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF4162D2),
      ),
      child: SafeArea(
        child: Container(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: RefreshIndicator(
              onRefresh: () async {
                await BlocProvider.of<TopicListCubit>(context).checkLatest();
              },
              child: CustomScrollView(
                controller: _scrollController,
                physics: ClampingScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverHeader(),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverCategorySelector(),
                  ),
                  buildSliverTopicList(context),
                ],
              ),
            ),
            floatingActionButton: scrollToTop
                ? FloatingActionButton(
                    mini: true,
                    backgroundColor: kBackgroundColor,
                    child: Icon(Icons.arrow_upward_outlined),
                    onPressed: () {
                      var time = 500;
                      var state =
                          BlocProvider.of<TopicListCubit>(context).state;
                      if (state is TopicListSuccess) {
                        time += state.page * 400;
                      }

                      _scrollController.animateTo(
                        1,
                        duration: Duration(milliseconds: time),
                        curve: Curves.easeOut,
                      );

                      // _scrollController.jumpTo(1);
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
