part of 'widgets.dart';

class ReplySection extends StatelessWidget {
  const ReplySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      // borderRadius: BorderRadius.circular(15),
      child: Container(
        height: 50,
        // color: Colors.white,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
              prefixStyle: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              prefixText: '回复',
              contentPadding: EdgeInsets.only(left: 8),
            ),
          ),
        ),
      ),
    );
  }
}
