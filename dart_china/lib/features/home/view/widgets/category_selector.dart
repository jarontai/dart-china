part of 'widgets.dart';

class SliverCategorySelector extends SliverPersistentHeaderDelegate {
  final VoidCallback onSelect;

  SliverCategorySelector({required this.onSelect});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return BlocBuilder<TopicListBloc, TopicListState>(
        builder: (context, state) {
      var names = <String>[];
      var current = -1;
      if (state.status.isSuccess) {
        for (var cat in state.categories) {
          names.add(cat.name);
        }
        current = state.categoryIndex;
      }
      return Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        decoration: BoxDecoration(
          color: ColorPalette.topicBgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorPalette.topicBgColor,
              blurRadius: 0,
              spreadRadius: 0,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          children: [
            CategorySelector(
              names: names,
              current: current,
              onSelect: (index) {
                context
                    .read<TopicListBloc>()
                    .add(TopicListChangeCategory(categoryIndex: index));
                onSelect();
              },
            ),
          ],
        ),
      );
    });
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    Key? key,
    this.names = const [],
    this.current = 0,
    required this.onSelect,
  }) : super(key: key);

  final List<String> names;
  final ValueChanged<int> onSelect;
  final int current;

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];

    for (int i = 0; i < names.length; i++) {
      list.add(SelectButton(
        text: names[i],
        onPressed: () {
          onSelect(i);
        },
        selected: i == current,
        marginRight: 20,
      ));
    }

    return Container(
      height: 35,
      child: ListView(
        children: list,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
