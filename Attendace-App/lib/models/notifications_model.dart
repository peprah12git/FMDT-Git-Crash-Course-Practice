import 'package:hive/hive.dart';

part "notifications_model.g.dart";
@HiveType(typeId: 1)
class NotificationModels {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String body;
    @HiveField(2)
  final String timeStamp;

  NotificationModels(this.title, this.body, this.timeStamp);
}