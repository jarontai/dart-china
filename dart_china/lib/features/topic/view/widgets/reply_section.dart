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
  final DataCallback<String> onReply;

  @override
  _ReplySectionState createState() => _ReplySectionState();
}

class _ReplySectionState extends State<ReplySection> {
  bool _open = false;
  bool _empty = true;
  TextEditingController _textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(() {
      setState(() {
        _empty = _textEditingController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var iconData = Icons.chat;
    if (_open && !_empty) {
      iconData = Icons.send;
    }

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          // color: Colors.blue,
          margin: EdgeInsets.only(
            left: 31.5,
          ),
          child: _open
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.only(
                          left: 3,
                          right: 50,
                        ),
                        child: TextField(
                          controller: _textEditingController,
                          minLines: 1,
                          maxLines: 6,
                          decoration: InputDecoration(
                            isDense: true,
                            fillColor: Colors.grey.shade300,
                            filled: true,
                            border: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              gapPadding: 0,
                              borderRadius: BorderRadius.circular(4),
                              borderSide: BorderSide(
                                color: Colors.blue.shade400,
                                width: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox.shrink(),
        ),
        FloatingActionButton(
          mini: true,
          backgroundColor: ColorPalette.backgroundColor,
          child: Icon(iconData),
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
              if (_textEditingController.text.isEmpty) {
                setState(() {
                  _open = false;
                });
              } else {
                widget.onReply(_textEditingController.text);
                setState(() {
                  _open = false;
                });
              }
            }
          },
        )
      ],
    );
  }
}
