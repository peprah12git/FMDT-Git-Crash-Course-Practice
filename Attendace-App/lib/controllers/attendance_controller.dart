// ignore_for_file: unnecessary_null_comparison

// import 'package:get/get.dart';
import 'package:attendance_app/models/attendance_model.dart';
import 'package:attendance_app/services/attendance_service.dart';
import 'package:get/state_manager.dart';

AttendanceService authService = AttendanceService();

class AttendanceController extends GetxController {
  var isLoading = true.obs;
  var employeeAttendanceHistory = <AttendanceModel>[].obs;

  @override
  void onInit() {
    // getUser();
    // TODO: implement onInit
    super.onInit();
  }

  //Get the employeeAttendanceHistory information
  void getUser() async {
    try {
      var employeeAttendance = await authService.getAttendaceHistory();
      if (employeeAttendance != null) {
        print(
            "################################################################");
        employeeAttendanceHistory.value = employeeAttendance;
        print(
            "#####################${employeeAttendanceHistory[0].email}###################");
      }
    } finally {}
  }
}
