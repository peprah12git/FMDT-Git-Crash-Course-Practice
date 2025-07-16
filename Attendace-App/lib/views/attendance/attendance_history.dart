import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceHistory extends StatelessWidget {
  AttendanceHistory({super.key});
  final AttendanceController attendanceController =
      Get.find<AttendanceController>();

  formatDate({int? index}) {
    final DateTime clockIn = attendanceController
        .employeeAttendanceHistory.reversed
        .toList()[index!]
        .clockInTime;
    final DateFormat formatter = DateFormat("MMM d");
    final String formatted = formatter.format(clockIn);
    return formatted;
  }

  formatTime({int? index}) {
    final DateTime time = attendanceController
        .employeeAttendanceHistory.reversed
        .toList()[index!]
        .clockInTime;
    final DateFormat formatteredTime = DateFormat().add_jm();
    final String formattedTime = formatteredTime.format(time);
    return formattedTime;
  }

  formatClockOutTime({int? index}) {
    final DateTime time = attendanceController
        .employeeAttendanceHistory.reversed
        .toList()[index!]
        .clockOutTime!;
    final DateFormat formatteredTime = DateFormat().add_jm();
    final String formattedTime = formatteredTime.format(time);
    return formattedTime;
  }

  defaultFormatClockOutTime() {
    final DateTime time = DateTime.parse("2023-11-13T00:00:32.453Z");
    final DateFormat formatteredTime = DateFormat().add_jm();
    final String formattedTime = formatteredTime.format(time);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(title: "Attendance", canGoback: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Obx(() {
          return attendanceController.employeeAttendanceHistory.isEmpty
              ? const Text("No Attendance History")
              : Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          titleWrapper(
                              title: "Date", color: CustomeColors.secondary),
                          titleWrapper(
                            title: "Time In",
                            color: const Color(0xffDEF0E4),
                          ),
                          titleWrapper(
                            title: "Time Out",
                            color: const Color(0xffFFF0DA),
                          ),
                        ]),
                    Expanded(
                      child: ListView.builder(
                          itemCount: attendanceController
                              .employeeAttendanceHistory.length,
                          itemBuilder: (context, index) {
                            final date = formatDate(index: index);
                            final time = formatTime(index: index);
                            final clockOutTime =
                                formatClockOutTime(index: index);
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Material(
                                color: CustomeColors.lightGrey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: CustomeColors.primary,
                                        child: Text(
                                          date,
                                          style: TextStyle(
                                              fontSize: 8,
                                              color: CustomeColors.white),
                                        ),
                                      ),
                                      // Text(date),
                                      Text(time),
                                      Text(clockOutTime ==
                                              defaultFormatClockOutTime()
                                          ? "--:--"
                                          : clockOutTime),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
        }),
      ),
    );
  }

  Material titleWrapper({
    String? title,
    Color? color,
  }) {
    return Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 25),
          child: Text(
            title!,
            style: const TextStyle(fontSize: 12),
          ),
        ));
  }
}
