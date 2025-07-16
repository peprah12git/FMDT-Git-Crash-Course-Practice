// ignore_for_file: library_prefixes

import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/controllers/leave_controller.dart';
import 'package:attendance_app/controllers/reports_controller.dart';
import 'package:attendance_app/controllers/task_controller.dart';
import 'package:attendance_app/main.dart';
import 'package:attendance_app/models/notifications_model.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/utils/images.dart';
import 'package:attendance_app/utils/router.dart';
//import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final EmployeeController employeeController = Get.put(EmployeeController());
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  final TaskController taskController = Get.put(TaskController());
  final LeaveController leaveController = Get.put(LeaveController());
  final ReportController reportController = Get.put(ReportController());
  List<Map> messages = [];
  Box<NotificationModels>? notifications;

  IO.Socket? socket;

  @override
  void initState() {
    notifications = Hive.box<NotificationModels>('notifications');

    employeeController.onInit();
    attendanceController.onInit();
    taskController.onInit();
    leaveController.onInit();
    reportController.onInit();
    getUserDataIfloggegIn();
    connectToServer();
    // initSocket();
    super.initState();
  }

  getUserDataIfloggegIn() {
    final employeedId = sharedPreferences.getString("userId");
    // ignore: unnecessary_null_comparison
    if (employeedId != null) {
      attendanceController.getUser();
      taskController.getAllTask();
      leaveController.getAllLeaveHistiry();
      reportController.getReports();
    }
  }

  void connectToServer() {
    final employeedId = sharedPreferences.getString("userId");
    socket =
        IO.io('https://attendance-app-m0oa.onrender.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket?.connect();
    //socket?.onConnecting(
    //(data) => print("Connecting to the socket server::::::::::::::"));
    socket?.on('newNotification', (data) {
      print('Received message: $data');
      if (employeedId == data['to']) {
        // AwesomeNotifications().createNotification(
        //   content: NotificationContent(
        //       id: 1,
        //       backgroundColor: CustomeColors.white,
        //       channelKey: "basic_channel",
        //       title: data['title'].toString(),
        //       body: data['body'].toString()),
        // );
        final newNotification = NotificationModels(data['title'].toString(),
            data['body'].toString(), data['timestamp']);
        notifications!.add(newNotification);
        setState(() {
          messages.add(data);
        });
      } else if (data["to"] == "all") {
        // AwesomeNotifications().createNotification(
        //   content: NotificationContent(
        //       id: 1,
        //       backgroundColor: CustomeColors.white,
        //       channelKey: "basic_channel",
        //       title: data['title'].toString(),
        //       body: data['body'].toString()),
        // );
        final newNotification = NotificationModels(data['title'].toString(),
            data['body'].toString(), data['timestamp']);
        notifications!.add(newNotification);
        setState(() {
          messages.add(data);
        });
      }
    });
    socket?.onConnect((_) {
      print('Connected to the socket server');
    });

    socket?.onDisconnect((_) {
      print('Disconnected from the socket server');
    });

    socket?.onConnectError((data) => print("Connect error: $data"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(CustomImagaes.meet), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Get Your Attendance Recorded",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Lato",
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Keep track of your Attendance by clocking In and Out",
                    style: TextStyle(color: CustomeColors.white),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    CustomeColors.black.withOpacity(.1),
                    CustomeColors.black.withOpacity(.8),
                    CustomeColors.black,
                    CustomeColors.black,
                    CustomeColors.black,
                  ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                ),
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SafeArea(
                      child: CommonButton(
                          title: "Continue",
                          onTap: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            final userId =
                                sharedPreferences.getString("userId");
                            userId != null
                                ? Get.toNamed(AppRouter.dashboard)
                                : Get.toNamed(AppRouter.signIn);
                          }),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    this.title,
    this.onTap,
  });
  final String? title;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
            // color: Colors.red,
            gradient: LinearGradient(colors: [
              CustomeColors.primary,
              CustomeColors.primary,
              CustomeColors.secondary,
            ]),
            borderRadius: BorderRadius.circular(6)),
        child: Center(
          child: Text(
            title!,
            style: TextStyle(
                color: CustomeColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
