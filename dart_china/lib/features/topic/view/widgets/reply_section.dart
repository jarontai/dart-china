part of 'widgets.dart';

class ReplySection extends StatefulWidget {
  const ReplySection({
    Key? key,
    this.canOpen = false,
    required this.onReject,
    required this.onReply,
  }) : super(key: key);

  final bool canOpen;
  final VoidCallback onReject;
  final StringCallback onReply;

  @override
  _ReplySectionState createState() => _ReplySectionState();
}

class _ReplySectionState extends State<ReplySection> {
  bool _open = false;
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          color: Colors.blue,
          margin: EdgeInsets.only(
            left: 31.5,
          ),
          child: _open
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 50,
                        ),
                        child: TextField(),
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ),
        FloatingActionButton(
          mini: true,
          backgroundColor: ColorPalette.backgroundColor,
          child: Icon(Icons.send),
          onPressed: () {
            if (!widget.canOpen) {
              widget.onReject();
              return;
            }

            if (!_open) {
              setState(() {
                _open = true;
              });
            } else {
              widget.onReply(_text);
            }
          },
        )
      ],
    );
  }
}
