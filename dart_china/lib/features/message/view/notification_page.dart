import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common.dart';
import '../../../models/models.dart' as models;
import '../../../util.dart';
import '../../../widgets/widgets.dart';
import '../../features.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final ScrollController _scrollController = ScrollController();
  late String? _username;

  @override
  void initState() {
    super.initState();

    final global = context.read<GlobalCubit>().state;
    if (global.userLogin && global.user != null) {
      _username = global.user?.username;
      if (_username != null) {
        context.read<NotificationCubit>().fetch(_username!, refresh: true);
      }
    }

    _scrollController.addListener(() {
      if (_username != null && _scrollController.hasClients) {
        var maxExtent = _scrollController.position.maxScrollExtent;
        if (_scrollController.offset >= (maxExtent * 0.9) &&
            !_scrollController.position.outOfRange) {
          context.read<NotificationCubit>().fetch(_username!);
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state.status.isInitial) {
                  return Column(
                    children: [ListLoader()],
                  );
                } else if (state.status.isSuccess || state.status.isPaging) {
                  final notifications = state.notifications;
                  final itemCount = notifications.length;
                  print('itemCount: $itemCount');
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.only(top: 10),
                          itemBuilder: (context, index) {
                            if (index >= itemCount) {
                              return ListLoader();
                            }
                            final item = notifications[index];
                            return _buildItem(context, item);
                          },
                          itemCount:
                              state.status.isPaging ? itemCount + 1 : itemCount,
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

  ListTile _buildItem(BuildContext context, models.Notification item) {
    var title;
    var user;
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
        user = itemData.displayUsername;
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

    var color = item.read ? Colors.grey.shade500 : Colors.blue.shade400;
    return ListTile(
      contentPadding: EdgeInsets.only(
        left: 16,
        right: 0,
      ),
      horizontalTitleGap: 8,
      leading: Icon(icon),
      title: RichText(
        text: TextSpan(children: [
          if (user != null)
            TextSpan(text: user, style: TextStyle(color: Colors.black)),
          if (user != null) TextSpan(text: ' '),
          TextSpan(
              text: title,
              style: TextStyle(color: color),
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
      trailing: item.read
          ? null
          : Material(
              color: Colors.white,
              child: IconButton(
                splashRadius: 20,
                icon: Icon(Icons.drafts_outlined),
                onPressed: () async {
                  final global = context.read<GlobalCubit>().state;
                  if (global.user != null) {
                    final notificationCubit = context.read<NotificationCubit>();
                    await notificationCubit.readNotification(
                        global.user!.username, item.id);
                    notificationCubit.fetch(global.user!.username,
                        refresh: true);
                  }
                },
              ),
            ),
    );
  }
}
