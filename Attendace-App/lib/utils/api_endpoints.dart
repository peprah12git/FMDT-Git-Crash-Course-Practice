// ignore_for_file: constant_identifier_names

class APIEndpoints {
  static const String base_url =
      "https://calm-puce-monkey-shoe.cyclic.app/api/employee";
  static const String login = "/login";
  static const String clock_in = "/attendance/clock-in";
  static const String clock_out = "/attendance/clock-out";
  static const String get_attendance_history = "/attendance/";

  ///EMPLOYEE TASK ENDPOINTS///

  static const String get_all_task = "/task/";
  static const String create_task = '/create-task';
  static const String update_task = '/task/edit/';
  static const String delete_task = '/delete-task';

  ///EMPLOYEE LEAVE ENDPOINTS///
  static const String request_leave = '/leave-request';
  static const String getAll_leave_request = '/leave-history/';
  static const String update_leave_request = '/leave-request/update/';
  static const String delete_leave_request = '/leave-request/delete/';

  ///EMPLOYEE REPORTS ENDPOINTS///
  static const String create_report = '/new-report';
  static const String get_reports = '/reports/';
}
