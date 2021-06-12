part of 'widgets.dart';

Widget buildSliverTopicList(BuildContext context) {
  return BlocBuilder<TopicListCubit, TopicListState>(builder: (_, state) {
    if (state is TopicListSuccess && !state.loading) {
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
              state.more ? state.topics.length + 1 : state.topics.length,
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
