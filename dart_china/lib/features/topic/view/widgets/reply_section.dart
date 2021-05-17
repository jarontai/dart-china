part of 'widgets.dart';

class ReplySection extends StatefulWidget {
  const ReplySection({
    Key? key,
    this.enableSend = true,
    required this.onSubmit,
  }) : super(key: key);

  final bool enableSend;
  final StrDataCallback onSubmit;

  @override
  _ReplySectionState createState() => _ReplySectionState();
}

class _ReplySectionState extends State<ReplySection> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  hintText: '快速回复',
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.send,
                color: kBackgroundColor,
              ),
              onPressed: widget.enableSend
                  ? () {
                      widget.onSubmit(_textEditingController.text);
                    }
                  : null,
            ),
          ],
        ),
      ),
      // child: Container(
      //   height: 58,
      //   alignment: Alignment.centerLeft,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(15),
      //     color: Colors.white,
      //   ),
      //   padding: EdgeInsets.only(
      //     top: 8,
      //     bottom: 0,
      //   ),
      //   child: TextField(
      //     controller: _textEditingController,
      //     maxLines: 10,
      //     decoration: InputDecoration(
      //       border: InputBorder.none,
      //       focusedBorder: InputBorder.none,
      //       prefixStyle: TextStyle(
      //         fontSize: 1,
      //         color: Colors.black87,
      //       ),
      //       hintText: '快速回复',
      //       hintStyle: TextStyle(color: Colors.black54),
      //       contentPadding: EdgeInsets.symmetric(
      //         vertical: 5,
      //         horizontal: 15,
      //       ),
      //       suffixIcon: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: [
      //           IconButton(
      //             icon: Icon(
      //               Icons.send,
      //               color: kBackgroundColor,
      //             ),
      //             onPressed: () {
      //               print('send pressed');
      //             },
      //           ),
      //           // Text(
      //           //   '${_textEditingController.text.length} 字',
      //           //   style: TextStyle(
      //           //     fontSize: 12,
      //           //   ),
      //           // )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
