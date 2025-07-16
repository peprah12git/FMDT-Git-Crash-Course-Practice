// ignore_for_file: unnecessary_null_comparison

// import 'package:get/get.dart';
import 'package:attendance_app/models/user_model.dart';
import 'package:attendance_app/services/user_auth.dart';
import 'package:get/state_manager.dart';

AuthService authService = AuthService();

class EmployeeController extends GetxController {
  var isLoading = true.obs;
  var user = Employee().obs;
  var age = 0.obs;

  // setuserProfile(getAge) {
  //   age.value = getAge;
  //   print(age.value);
  // }

  setuser(userProfile) {
    user.value = userProfile;
    print(user.value.email);
  }

  @override
  void onInit() {
    // getUser();
    // TODO: implement onInit
    super.onInit();
  }
}
