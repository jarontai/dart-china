part of 'widgets.dart';

class SliverCategorySelector extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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

class CategorySelector extends StatefulWidget {
  const CategorySelector({
    Key? key,
    this.configMap = const {
      'all': '全部',
      'share': '分享',
      'question': '问答',
      'meta': '站务',
    },
    required this.onSelect,
  }) : super(key: key);

  final Map<String, String> configMap;
  final IndexCallback onSelect;

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];
    var values = widget.configMap.values;
    for (int i = 0; i < values.length; i++) {
      list.add(SelectButton(
        text: values.elementAt(i),
        onPressed: () {
          setState(() {
            selectedIndex = i;
          });
          widget.onSelect(i);
        },
        selected: selectedIndex == i,
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
