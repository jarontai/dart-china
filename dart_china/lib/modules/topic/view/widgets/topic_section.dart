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
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        children: [
          TopicTypeSelector(
            onSelect: (index) {
              print('select topic $index');
            },
          ),
          CategorySelector(
            names: [],
            nums: [],
          ),
        ],
      ),
    );
  }
}

class TopicTypeSelector extends StatelessWidget {
  const TopicTypeSelector({
    Key? key,
    this.configMap = const {
      'latest': '最新',
      'hot': '最热',
    },
    required this.onSelect,
    this.selectedIndex = 0,
  }) : super(key: key);

  final Map<String, String> configMap;
  final int selectedIndex;
  final IndexCallback onSelect;

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];
    var values = configMap.values;
    for (int i = 0; i < values.length; i++) {
      list.add(Button(
        text: values.elementAt(i),
        onPressed: () {
          onSelect(i);
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
