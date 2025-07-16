// ignore_for_file: constant_identifier_names

import 'package:attendance_app/views/athentication/sign_in.dart';
import 'package:attendance_app/views/dashboard/dashboard.dart';
import 'package:attendance_app/views/dashboard/splash.dart';
import 'package:attendance_app/views/home/calender/calender.dart';
import 'package:attendance_app/views/home/leave/leave.dart';
import 'package:attendance_app/views/home/leave/leave_history.dart';
import 'package:attendance_app/views/home/reports/report.dart';
import 'package:attendance_app/views/home/task/task.dart';
import 'package:attendance_app/views/notifications/notifications.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

class AppRouter {
  static const String initial = "/";
  static const String signIn = "/signIn";
  static const String dashboard = "/dashboard";
  static const String Task = "/task";
  static const String Report = "/report";
  static const String Calender = "/calender";
  static const String Leave = "/leave";
  static const String notifications = "/notifications";
  static const String leaveHistory = "/leaveHistory";

  static List<GetPage> routes = [
    GetPage(
        name: initial, page: () => const SplashView(), curve: Curves.easeIn),
    GetPage(name: signIn, page: () => const SignInView(), curve: Curves.easeIn),
    GetPage(
        name: notifications,
        page: () => const NotificationsView(),
        curve: Curves.easeIn),
    GetPage(
        name: dashboard,
        page: () => const DashBoardView(),
        curve: Curves.easeIn),
    GetPage(name: Task, page: () => const TaskView(), curve: Curves.easeIn),
    GetPage(name: Report, page: () => const Reports(), curve: Curves.easeIn),
    GetPage(
        name: Calender, page: () => const CalenderVC(), curve: Curves.easeIn),
    GetPage(name: Leave, page: () => const LeaveVC(), curve: Curves.easeIn),
    GetPage(
        name: leaveHistory, page: () => const LeaveHistory(), curve: Curves.easeIn),
  ];
}
