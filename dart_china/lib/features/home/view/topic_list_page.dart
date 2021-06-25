import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../common.dart';
import '../../../widgets/widgets.dart';
import '../../features.dart';
import '../bloc/topic_list_bloc.dart';
import 'widgets/widgets.dart';

class TopicListPage extends StatefulWidget {
  @override
  _TopicListPageState createState() => _TopicListPageState();
}

class _TopicListPageState extends State<TopicListPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  bool showToTop = false;

  @override
  void initState() {
    super.initState();

    context.read<TopicListBloc>().add(TopicListFetch(refresh: true));

    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        var maxExtent = _scrollController.position.maxScrollExtent;
        if (_scrollController.offset >= (maxExtent * 0.9) &&
            !_scrollController.position.outOfRange) {
          context.read<TopicListBloc>().add(TopicListFetch(refresh: false));
        }

        var shouldScrollTop = false;
        if (_scrollController.offset >= (150) &&
            !_scrollController.position.outOfRange) {
          shouldScrollTop = true;
        }
        setState(() {
          showToTop = shouldScrollTop;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: RefreshIndicator(
            key: _refreshKey,
            onRefresh: () async {
              context.read<TopicListBloc>().add(TopicListPoll());
            },
            child: CustomScrollView(
              controller: _scrollController,
              physics: ClampingScrollPhysics(),
              slivers: [
                BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return SliverPersistentHeader(
                      pinned: true,
                      delegate: HomeSliverHeader(
                        onMenuPressed: () {
                          if (ZoomDrawer.of(context)!.isOpen()) {
                            ZoomDrawer.of(context)?.close();
                          } else {
                            ZoomDrawer.of(context)?.open();
                          }
                        },
                        onSearchPressed: () {
                          Navigator.of(context).pushNamed(Routes.search);
                        },
                        badge: state.hasNotification,
                      ),
                    );
                  },
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverCategorySelector(onSelect: () {
                    _jumpToTop();
                  }),
                ),
                _buildSliverTopicList(context),
              ],
            ),
          ),
          floatingActionButton: showToTop
              ? FloatingActionButton(
                  mini: true,
                  backgroundColor: ColorPalette.backgroundColor,
                  child: Icon(Icons.arrow_upward_outlined),
                  onPressed: () {
                    _jumpToTop();
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildSliverTopicList(BuildContext context) {
    return BlocBuilder<TopicListBloc, TopicListState>(builder: (_, state) {
      if (state.status.isSuccess) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (_, index) {
              return Container(
                decoration: BoxDecoration(
                  color: ColorPalette.topicBgColor,
                  boxShadow: [
                    BoxShadow(
                      color: ColorPalette.topicCardColor,
                      blurRadius: 0,
                      spreadRadius: 0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: index >= state.topics.length
                    ? ListLoader()
                    : TopicCard(
                        topic: state.topics[index],
                      ),
              );
            },
            childCount:
                state.paging ? state.topics.length + 1 : state.topics.length,
          ),
        );
      } else {
        return SliverFillRemaining(
          child: Container(
            padding: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              color: ColorPalette.topicBgColor,
              boxShadow: [
                BoxShadow(
                  color: ColorPalette.topicCardColor,
                  blurRadius: 0,
                  spreadRadius: 0,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      }
    });
  }
}
