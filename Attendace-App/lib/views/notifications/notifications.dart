import 'package:attendance_app/components/notification_card.dart';
import 'package:attendance_app/models/notifications_model.dart';
import 'package:attendance_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({Key? key}) : super(key: key);

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  Box<NotificationModels>? notifications;
  @override
  void initState() {
    notifications = Hive.box<NotificationModels>('notifications');

    super.initState();
  }

  void delateNotification(index) {
    notifications!.deleteAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Notifications"),
      body: Column(
        children: [
          Expanded(
              child: ValueListenableBuilder(
                  valueListenable: notifications!.listenable(),
                  builder: (context, Box box, widget) {
                    return SafeArea(
                        child: box.length > 0
                            ? ListView.builder(
                                itemCount: box.length,
                                itemBuilder: (context, index) {
                                  NotificationModels notification = box.values
                                      .toList()
                                      .reversed
                                      .toList()[index];
                                  return NotificationCardComponent(
                                    notifications: notification,
                                    onTap: () {
                                      delateNotification(index);
                                      Navigator.pop(context);
                                    },
                                  );
                                })
                            : const Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("No notifications"),
                                    Text("New notifications will appear here"),
                                  ],
                                ),
                              ));
                  })),
        ],
      ),
    );
  }
}
