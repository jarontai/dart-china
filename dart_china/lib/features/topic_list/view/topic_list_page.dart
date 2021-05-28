import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../commons.dart';
import '../cubit/topic_list_cubit.dart';
import 'widgets/widgets.dart';

class TopicListPage extends StatefulWidget {
  static final String routeName = '/topic_list';

  @override
  _TopicListPageState createState() => _TopicListPageState();
}

class _TopicListPageState extends State<TopicListPage> {
  late ScrollController _scrollController;
  bool scrollToTop = false;
  late GlobalKey<RefreshIndicatorState> _refreshKey;

  @override
  void initState() {
    super.initState();

    context.read<TopicListCubit>().fetchLatest();

    _refreshKey = GlobalKey<RefreshIndicatorState>();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        var maxExtent = _scrollController.position.maxScrollExtent;
        if (_scrollController.offset >= (maxExtent * 0.9) &&
            !_scrollController.position.outOfRange) {
          context.read<TopicListCubit>().fetchLatest();
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
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  _scrollToTop() async {
    var time = 500;
    var state = context.read<TopicListCubit>().state;
    if (state is TopicListSuccess) {
      time += state.page * 400;
    }
    await _scrollController.animateTo(
      1,
      duration: Duration(milliseconds: time),
      curve: Curves.easeOut,
    );
  }

  _jumpToTop() {
    _scrollController.jumpTo(1);
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
              key: _refreshKey,
              onRefresh: () async {
                await context.read<TopicListCubit>().checkLatest();
              },
              child: CustomScrollView(
                controller: _scrollController,
                physics: ClampingScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverHeader(
                      onMenuPressed: () {
                        if (ZoomDrawer.of(context)!.isOpen()) {
                          ZoomDrawer.of(context)?.close();
                        } else {
                          ZoomDrawer.of(context)?.open();
                        }
                      },
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverCategorySelector(onSelect: () {
                      _jumpToTop();
                    }),
                  ),
                  buildSliverTopicList(context),
                ],
              ),
            ),
            floatingActionButton: scrollToTop
                ? FloatingActionButton(
                    mini: true,
                    backgroundColor: ColorPalette.backgroundColor,
                    child: Icon(Icons.arrow_upward_outlined),
                    onPressed: () {
                      // _scrollToTop();
                      _jumpToTop();
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
