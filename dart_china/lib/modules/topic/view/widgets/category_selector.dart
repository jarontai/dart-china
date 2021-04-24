part of 'widgets.dart';

class CategorySelector extends StatefulWidget {
  const CategorySelector({
    Key? key,
    required this.names,
    required this.nums,
    this.colors = const [
      Color(0xFF435AE4),
      Color(0xFF40a37e),
      Color(0xFFd9a01c),
      Color(0xFFa19b8f)
    ],
    required this.onSelect,
  })   : assert(names.length == nums.length),
        assert(names.length == colors.length),
        super(key: key);

  final List<String> names;
  final List<int> nums;
  final List<Color> colors;
  final IndexCallback onSelect;

  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];
    for (int i = 0; i < widget.names.length; i++) {
      list.add(CategoryBlock(
        name: widget.names[i],
        postNum: widget.nums[i],
        onPressed: () {
          setState(() {
            selectedIndex = i;
          });
          widget.onSelect(i);
        },
        selected: selectedIndex == i,
        color: widget.colors[i],
      ));
    }
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '主题分类',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: list,
          )
        ],
      ),
    );
  }
}

class CategoryBlock extends StatelessWidget {
  const CategoryBlock({
    Key? key,
    required this.name,
    required this.postNum,
    required this.onPressed,
    required this.color,
    this.selected = false,
  }) : super(key: key);

  final String name;
  final int postNum;
  final Color color;
  final VoidCallback onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    var textColor;
    if (selected) {
      textColor = Color(0xFFEFF2FF);
    } else {
      textColor = Colors.grey.shade300;
    }

    return Container(
      width: selected ? 60 : 52,
      height: selected ? 60 : 52,
      padding: EdgeInsets.only(
          // top: 15,
          // left: 15,
          ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'x $postNum',
              style: TextStyle(
                color: textColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
