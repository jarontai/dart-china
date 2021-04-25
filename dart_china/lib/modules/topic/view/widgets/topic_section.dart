part of 'widgets.dart';

class TopicSection extends StatelessWidget {
  const TopicSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF1F6FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 15,
      ),
      child: Column(
        children: [
          TopicTypeSelector(
            onSelect: (index) {
              print('select topic $index');
            },
          ),
          SizedBox(
            height: 40,
            child: Align(
              child: SectionTitle(text: '主题分类'),
              alignment: Alignment.centerLeft,
            ),
          ),
          CategorySelector(
            names: ['全部', '分享', '问答', '站务'],
            nums: [100, 62, 30, 2],
            onSelect: (index) => print('category select: $index'),
          ),
          SizedBox(
            height: 55,
            child: Align(
              child: SectionTitle(text: '主题列表'),
              alignment: Alignment.centerLeft,
            ),
          ),
          Expanded(child: TopicList()),
        ],
      ),
    );
  }
}

class TopicTypeSelector extends StatefulWidget {
  const TopicTypeSelector({
    Key? key,
    this.configMap = const {
      'latest': '最新',
      'hot': '最热',
    },
    required this.onSelect,
  }) : super(key: key);

  final Map<String, String> configMap;
  final IndexCallback onSelect;

  @override
  _TopicTypeSelectorState createState() => _TopicTypeSelectorState();
}

class _TopicTypeSelectorState extends State<TopicTypeSelector> {
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
      child: Row(children: list),
    );
  }
}
