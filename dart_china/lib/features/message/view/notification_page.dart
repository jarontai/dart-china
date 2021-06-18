import 'package:dart_china/models/models.dart' as models;
import 'package:dart_china/util.dart';
import 'package:dart_china/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common.dart';
import '../../features.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    super.initState();

    final global = context.read<GlobalCubit>().state;
    if (global.userLogin && global.user != null) {
      final username = global.user?.username;
      if (username != null) {
        context.read<NotificationCubit>().fetch(username, refresh: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: ColorPalette.backgroundColor,
          appBar: AppBar(
            title: Text(
              '消息',
            ),
            backgroundColor: ColorPalette.backgroundColor,
            elevation: 0,
          ),
          body: Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                final myState = state;

                if (myState is NotificationLoading) {
                  return Column(
                    children: [ListLoader()],
                  );
                } else if (myState is NotificationSuccess) {
                  final notifications = myState.notifications;
                  final itemCount = notifications.length;
                  return Column(
                    children: [
                      Row(
                        children: [Text('通知列表')],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            if (index >= itemCount) {
                              return ListLoader();
                            }
                            final item = notifications[index];
                            return _buildItem(item);
                          },
                          itemCount: myState.paging ? itemCount + 1 : itemCount,
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ),
        ));
  }

  ListTile _buildItem(models.Notification item) {
    var title;
    var username;
    var time = DateTime.parse(item.createdAt);
    var topicId = item.topicId;
    var itemData = item.data;
    if (itemData != null) {
      if (itemData.badgeName != null) {
        title = '获得 "${itemData.badgeName ?? ''}"';
      } else if (itemData.inboxCount != null) {
        title = '${itemData.inboxCount}条私信在版主收件箱';
      } else {
        title = itemData.topicTitle;
      }

      if (title != null &&
          itemData.displayUsername != null &&
          itemData.displayUsername!.isNotEmpty) {
        username = itemData.displayUsername;
      }
    }

    if (title == null) {
      title ??= '-';
    }

    var icon = Icons.info_outline;
    switch (item.type) {
      case models.NotificationType.GrantedBadge:
        icon = Icons.military_tech_outlined;
        break;
      case models.NotificationType.Liked:
        icon = Icons.favorite_border_outlined;
        break;
      case models.NotificationType.PrivateMessage:
        icon = Icons.mail_outlined;
        break;
      case models.NotificationType.Edited:
        icon = Icons.edit_outlined;
        break;
      case models.NotificationType.Replied:
        icon = Icons.reply_outlined;
        break;
      case models.NotificationType.Unknown:
        icon = Icons.info_outline;
        break;

      default:
        break;
    }

    return ListTile(
      horizontalTitleGap: 8,
      leading: Icon(icon),
      title: RichText(
        text: TextSpan(children: [
          if (username != null)
            TextSpan(text: username, style: TextStyle(color: Colors.black87)),
          if (username != null) TextSpan(text: ' '),
          TextSpan(
              text: title,
              style: TextStyle(color: Colors.blue.shade700),
              recognizer: topicId == null
                  ? null
                  : (TapGestureRecognizer()
                    ..onTap = () {
                      print('Click message');
                    }))
        ]),
      ),
      subtitle: Text(
        TimeUtil.format(time),
        style: TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }
}
