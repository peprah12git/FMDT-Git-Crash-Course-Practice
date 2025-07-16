import 'package:attendance_app/controllers/notifications_controller.dart';
import 'package:attendance_app/models/notifications_model.dart';
// import 'package:attendance_app/models/notifications_model.dart';
import 'package:attendance_app/utils/router.dart';
//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter();
  Hive.registerAdapter(NotificationModelsAdapter());
  await Hive.openBox<NotificationModels>('notifications');
  // await AwesomeNotifications().initialize(
  //   null,
  //   [
  //     NotificationChannel(
  //         channelShowBadge: true,
  //         channelGroupKey: 'basic_channel_group',
  //         channelKey: 'basic_channel',
  //         channelName: 'Basic notifications',
  //         channelDescription: 'Notification channel for basic tests',
  //         // defaultColor: Color(0xFF9D50DD),
  //         ledColor: Colors.white)
  //   ],
  //   // Channel groups are only visual and are not required
  //   channelGroups: [
  //     NotificationChannelGroup(
  //         channelGroupKey: 'basic_channel_group',
  //         channelGroupName: 'Basic group')
  //   ],
  // );
  // bool isAllowedToSendNotifications =
  //     await AwesomeNotifications().isNotificationAllowed();
  // if (!isAllowedToSendNotifications) {
  //   AwesomeNotifications().requestPermissionToSendNotifications();
  // }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //   AwesomeNotifications().setListeners(
    //       onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    //       onNotificationCreatedMethod:
    //           NotificationController.onNotificationCreatedMethod,
    //       onNotificationDisplayedMethod:
    //           NotificationController.onNotificationDisplayedMethod,
    //       onDismissActionReceivedMethod:
    //           NotificationController.onDismissActionReceivedMethod);
    //   // connectToServer();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRouter.initial,
      getPages: AppRouter.routes,
      builder: EasyLoading.init(),
    );
  }
}
