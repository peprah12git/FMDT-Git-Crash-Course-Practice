import 'dart:convert';

import 'package:attendance_app/main.dart';

getUserProfile() {
  String encodedMap = sharedPreferences.getString('employeeData') ?? '';
  Map<String, dynamic> retrievedMap = jsonDecode(encodedMap);
  return retrievedMap;
}
