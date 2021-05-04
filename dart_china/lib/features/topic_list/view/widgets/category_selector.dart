part of 'widgets.dart';

class SliverCategorySelector extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // var categories;
    // var state = BlocProvider.of<TopicListCubit>(context).state;
    // if (state is TopicListSuccess) {
    //   state.
    // }

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF1F6FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFF1F6FA),
            blurRadius: 0,
            spreadRadius: 0,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        children: [
          CategorySelector(
            onSelect: (index) {
              print('select topic $index');
            },
          ),
        ],
      ),
    );
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
    this.categories = const {
      'all': 'all',
    },
    this.current = 'all',
    required this.onSelect,
  }) : super(key: key);

  final Map<String, String> categories;
  final StrDataCallback onSelect;
  final String current;

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];

    for (var entry in categories.entries) {
      list.add(SelectButton(
        text: entry.value,
        onPressed: () {
          onSelect(entry.key);
        },
        selected: entry.key == current,
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
