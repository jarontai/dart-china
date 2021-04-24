part of 'widgets.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({
    Key? key,
    required this.names,
    required this.nums,
  }) : super(key: key);

  final List<String> names;
  final List<int> nums;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '主题分类',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [CategoryBlock()],
          )
        ],
      ),
    );
  }
}

class CategoryBlock extends StatelessWidget {
  const CategoryBlock({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      padding: EdgeInsets.only(
          // top: 15,
          // left: 15,
          ),
      decoration: BoxDecoration(
        color: Color(0xFF7C15BF),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '分享',
              style: TextStyle(
                color: Color(0xFFEFF2FF),
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'x 30',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
