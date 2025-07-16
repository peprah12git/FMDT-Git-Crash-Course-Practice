import 'package:attendance_app/models/notifications_model.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationCardComponent extends StatelessWidget {
  const NotificationCardComponent({Key? key, this.notifications,this.onTap})
      : super(key: key);

  final NotificationModels? notifications;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    formatDate() {
      final DateTime timeCreate = DateTime.parse(notifications!.timeStamp);
      final DateFormat formatter = DateFormat("MMM d");
      final String formatted = formatter.format(timeCreate);
      final DateFormat formatteredTime = DateFormat().add_jm();
      final String formattedTime = formatteredTime.format(timeCreate);
      return "$formatted $formattedTime";
    }

    return Card(
      surfaceTintColor: CustomeColors.white,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: CustomeColors.primary,
                child: const Icon(
                  FeatherIcons.bell,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notifications!.title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(notifications!.body,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 14)),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(formatDate(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontSize: 10)),
                    )
                  ],
                ),
              ),
              InkWell(
                child: const Icon(Icons.more_vert),
                onTap: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) => Material(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(FeatherIcons.bell),
                                    title: Text(
                                      "Mark as read",
                                      style: TextStyle(
                                          color: CustomeColors.primary),
                                    ),
                                    onTap: () => Navigator.pop(context),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: ListTile(
                                      onTap: onTap,
                                      title: Text(
                                        "Delete Notification",
                                        style: TextStyle(
                                            color: CustomeColors.primary),
                                      ),
                                      leading: const Icon(
                                        Icons.delete,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
