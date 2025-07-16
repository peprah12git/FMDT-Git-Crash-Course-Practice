// ignore_for_file: unnecessary_null_comparison

import 'package:attendance_app/models/leave_model.dart';
import 'package:attendance_app/services/leave_service.dart';
import 'package:get/state_manager.dart';

LeaveService leaveService = LeaveService();

class LeaveController extends GetxController {
  var isLoading = true.obs;
  var employeeLeaveHistory = <LeaveModel>[];

  @override
  void onInit() {
    // getUser();
    // TODO: implement onInit
    super.onInit();
  }

  //Get the employeeLeaveHistory information
  void getAllLeaveHistiry() async {
    try {
      var employeeLeave = await leaveService.getLeaveHistory();
      if (employeeLeave != null) {
        print(
            "################################################################");
        employeeLeaveHistory = employeeLeave;
        print(
            "#####################${employeeLeaveHistory[0].reason}###################");
      }
    } finally {}
    update();
  }
}
