import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/controllers/leave_controller.dart';
import 'package:attendance_app/controllers/reports_controller.dart';
import 'package:attendance_app/controllers/task_controller.dart';
import 'package:attendance_app/services/attendance_service.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/utils/images.dart';
import 'package:attendance_app/utils/router.dart';
import 'package:attendance_app/utils/shared_prefs.dart';
import 'package:attendance_app/views/dashboard/splash.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:loading_indicator/loading_indicator.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final EmployeeController userController = Get.find<EmployeeController>();
  final AttendanceService _attendanceService = AttendanceService();
  @override
  Widget build(BuildContext context) {
    final user = getUserProfile();
    DateTime now = DateTime.now();

    var textStyle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: CustomeColors.black);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomeColors.primary,
        toolbarHeight: 100,
        title: Row(
          children: [
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  CustomImagaes.hand,
                  height: 20,
                ),
                Text(
                  "Hey ${user['name']}",
                  style: TextStyle(color: CustomeColors.white, fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  user['role'],
                  style: smallTextStyle.copyWith(color: CustomeColors.white),
                ),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(AppRouter.notifications),
              icon: Icon(
                FeatherIcons.bell,
                color: CustomeColors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 6,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: index == 0
                            ? () => Get.toNamed(AppRouter.Task)
                            : index == 1
                                ? () => Get.toNamed(AppRouter.leaveHistory)
                                : () {},
                        child: Container(
                          padding: const EdgeInsetsDirectional.all(5),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                              color: CustomeColors.primary,
                              borderRadius: BorderRadius.circular(10)),
                          width: MediaQuery.sizeOf(context).width / 1.7,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                topItems[index]["icon"],
                                color: CustomeColors.white,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    topItems[index]["title"],
                                    style: smallTextStyle.copyWith(
                                        fontSize: 16,
                                        color: CustomeColors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    topItems[index]["subTitle"],
                                    style: smallTextStyle,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      "View",
                                      style: smallTextStyle,
                                    ),
                                  )
                                ],
                              ))
                            ],
                          ),
                        ),
                      ),
                  itemCount: topItems.length),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style: textStyle,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child:
                            GetBuilder<TaskController>(builder: (controller) {
                          return OfficeServiceWidget(
                            title: "Task",
                            subTitle: controller.employeeTaskHistory.length
                                .toString(),
                            icon: Icons.list,
                            onTap: () => Get.toNamed(AppRouter.Task),
                          );
                        }),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child:
                            GetBuilder<ReportController>(builder: (controller) {
                          return OfficeServiceWidget(
                            title: "Report",
                            icon: FeatherIcons.file,
                            subTitle: controller.employeeReportsHistory.length
                                .toString(),
                            onTap: () => Get.toNamed(AppRouter.Report),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OfficeServiceWidget(
                          title: "Calender",
                          icon: FeatherIcons.calendar,
                          onTap: () => Get.toNamed(AppRouter.Calender),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child:
                            GetBuilder<LeaveController>(builder: (controller) {
                          return OfficeServiceWidget(
                            title: "Leave Request",
                            icon: FeatherIcons.fileText,
                            subTitle: controller.employeeLeaveHistory.length
                                .toString(),
                            onTap: () => Get.toNamed(AppRouter.Leave),
                          );
                        }),
                      ),
                    ],
                  ),
                ],
                /////////
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height / 8,
            ),
            Center(
                child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(),
                    context: context,
                    builder: (context) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(
                                    now.hour < 12
                                        ? "Register your presence and start work"
                                        : "Sign your departure and have a happy day",
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                CommonButton(
                                  title: "Clock-In",
                                  onTap: () async {
                                    _attendanceService
                                        .markAttendance(
                                            context: context, type: "clock-in")
                                        .whenComplete(
                                            () => Navigator.pop(context));
                                  },
                                ),
                                const SizedBox(height: 10),
                                CommonButton(
                                  title: "Clock-Out",
                                  onTap: () async {
                                    _attendanceService
                                        .markAttendance(
                                            context: context, type: "clock-out")
                                        .whenComplete(
                                            () => Navigator.pop(context));
                                    // Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ));
              },
              child: CircleAvatar(
                radius: 50,
                backgroundColor: CustomeColors.primary,
                child: Icon(Icons.fingerprint, color: CustomeColors.white, size: 30,),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Material materialButton({
    String? text,
  }) {
    return Material(
        color: CustomeColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            text!,
            style: TextStyle(color: CustomeColors.white),
          ),
        ));
  }
}

class OfficeServiceWidget extends StatelessWidget {
  const OfficeServiceWidget({
    super.key,
    this.title,
    this.icon,
    this.onTap,
    this.subTitle,
  });
  final String? title;
  final String? subTitle;
  final IconData? icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 100,
        decoration: BoxDecoration(
            // color: CustomeColors.primary,
            color: const Color(0xffEFF3FE),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  color: CustomeColors.primary,
                  size: 30,
                ),
                Icon(
                  Icons.more_vert,
                  size: 20,
                  color: CustomeColors.primary,
                )
              ],
            ),
            Column(
              children: [
                Text(
                  title!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: CustomeColors.primary),
                ),
                Text(subTitle ?? "", style: smallTextStyle)
              ],
            )
          ],
        ),
      ),
    );
  }
}

List<Map> topItems = [
  {
    "title": "Todays Task",
    "subTitle": "View all today created task",
    "icon": FeatherIcons.list
  },
  {
    "title": "Recent Leave Request",
    "subTitle": "Check the status of your recent leave requests",
    "icon": FeatherIcons.file
  },
  {
    "title": "Notifications",
    "subTitle": "Stay updated of all informations from the company",
    "icon": FeatherIcons.bell
  }
];
var smallTextStyle = TextStyle(fontSize: 11, color: CustomeColors.grey);
