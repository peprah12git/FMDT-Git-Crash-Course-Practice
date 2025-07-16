// ignore_for_file: unnecessary_null_comparison

import 'package:attendance_app/models/reports_model.dart';
import 'package:attendance_app/services/reports_service.dart';
import 'package:get/state_manager.dart';

ReportService resportService = ReportService();

class ReportController extends GetxController {
  var isLoading = true.obs;
  var employeeReportsHistory = <Report>[];

  @override
  void onInit() {
    // getUser();
    // TODO: implement onInit
    super.onInit();
  }

  //Get the employeeReports History
  void getReports() async {
    try {
      var employeeLeave = await resportService.getUserReports();
      if (employeeLeave != null) {
        print(
            "################################################################");
        employeeReportsHistory = employeeLeave.reports;
        print(
            "#####################${employeeReportsHistory[0].id}###################");
      }
    } finally {}
    update();
  }
}
