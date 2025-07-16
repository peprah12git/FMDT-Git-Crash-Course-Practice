// ignore_for_file: null_check_always_fails

import 'dart:convert';

import 'package:attendance_app/controllers/attendance_controller.dart';
import 'package:attendance_app/controllers/employee_controller.dart';
import 'package:attendance_app/controllers/leave_controller.dart';
import 'package:attendance_app/controllers/reports_controller.dart';
import 'package:attendance_app/controllers/task_controller.dart';
import 'package:attendance_app/main.dart';
import 'package:attendance_app/models/user_model.dart';
import 'package:attendance_app/utils/api_endpoints.dart';
import 'package:attendance_app/utils/constant.dart';
import 'package:attendance_app/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

final EmployeeController userController = Get.find<EmployeeController>();
final AttendanceController attendanceController =
    Get.find<AttendanceController>();
final TaskController taskController = Get.find<TaskController>();
final LeaveController leaveController = Get.find<LeaveController>();
final ReportController reportsController = Get.find<ReportController>();

class AuthService {
  final GetConnect _connect = GetConnect(timeout: const Duration(seconds: 30));
  Logger logger = Logger();
  Future signInUser({
    String? email,
    String? staffId,
    BuildContext? context,
  }) async {
    loadingBar(context!, title: "Loging in...");
    try {
      final res = await _connect.post(
          "${APIEndpoints.base_url}/${APIEndpoints.login}",
          {"email": email, "staffId": staffId});
      if (res.statusCode == 200) {
        logger.d(res.body);
        //Get and store employee Id
        String id = res.body['employee']['id'];
        sharedPreferences.setString("userId", id);
        String encodedMap = jsonEncode(res.body['employee']);
        await sharedPreferences.setString('employeeData', encodedMap);
        if (context.mounted) {
          Navigator.pop(context);
          Get.toNamed(AppRouter.dashboard);
          userController.setuser(Employee.fromJson(res.body['employee']));
          attendanceController.getUser();
          taskController.getAllTask();
          leaveController.getAllLeaveHistiry();
          reportsController.getReports();
        }
      } else {
        String message = res.body['message'];
        logger.d(res.body);
        if (context.mounted) {
          Navigator.pop(context);
          showSnackBar(message: message, isError: true);
        }

        return null!;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  logoutUser({BuildContext? context}) {
    loadingBar(context!, title: "Logging out...");
    // SharedPreferences pref = await SharedPreferences.getInstance();
    Future.delayed(const Duration(seconds: 5), () {
      sharedPreferences.remove('employeeData');
      sharedPreferences.remove("userId");
      Get.offNamed(AppRouter.signIn);
    });
    if (context.mounted) {}
  }
}
