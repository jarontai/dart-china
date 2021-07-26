part of 'widgets.dart';

typedef ImagePickCallback = Function(XFile file);

class EditableAvatar extends StatefulWidget {
  EditableAvatar({required this.avatar, this.onPickAvatar});

  final String avatar;
  final ImagePickCallback? onPickAvatar;

  @override
  _EditableAvatarState createState() => _EditableAvatarState();
}

class _EditableAvatarState extends State<EditableAvatar> {
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AvatarButton(
          size: 55,
          avatarUrl: widget.avatar,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: widget.onPickAvatar != null
              ? Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffd3def4),
                  ),
                  child: IconButton(
                    iconSize: 15,
                    padding: EdgeInsets.all(1),
                    icon: Icon(Icons.edit_outlined),
                    onPressed: () async {
                      final image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        widget.onPickAvatar!(image);
                      }

                      Future.delayed(Duration(milliseconds: 10), () async {
                        final response = await _picker.retrieveLostData();
                        if (response.isEmpty) {
                          return;
                        } else if (response.file != null) {
                          widget.onPickAvatar!(response.file!);
                        }
                      });
                    },
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}
