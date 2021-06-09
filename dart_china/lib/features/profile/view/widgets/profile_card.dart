part of 'widgets.dart';

typedef ImagePickCallback = Function(PickedFile file);

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    this.onPickAvatar,
  }) : super(key: key);

  final ImagePickCallback? onPickAvatar;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          EditableAvatar(
            avatar: '',
            onPickAvatar: onPickAvatar,
          ),
        ],
      ),
    );
  }
}

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
        AvatarButton(size: 60, avatarUrl: widget.avatar),
        Positioned(
          right: 2,
          bottom: 5,
          child: widget.onPickAvatar != null
              ? Container(
                  width: 25,
                  height: 25,
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
                          await _picker.getImage(source: ImageSource.gallery);
                      if (image != null) {
                        widget.onPickAvatar!(image);
                      }

                      Future.delayed(Duration(milliseconds: 10), () async {
                        final response = await _picker.getLostData();
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
