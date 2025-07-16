import 'package:attendance_app/components/common_textfield.dart';
import 'package:attendance_app/services/leave_service.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/utils/constant.dart';
import 'package:attendance_app/views/dashboard/splash.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class LeaveVC extends StatefulWidget {
  const LeaveVC({super.key});

  @override
  State<LeaveVC> createState() => _LeaveVCState();
}

class _LeaveVCState extends State<LeaveVC> {
  LeaveService leaveService = LeaveService();

  final TextEditingController reasonController = TextEditingController();

  List leaveType = ["Sick", "Maternity"];
  String? selectedleaveType;

  DateTime _startSelectedDate = DateTime.now();
  DateTime _endSelectedDate = DateTime.now();
  String? formattedStartDate;
  String? formattedEndDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.white,
      appBar: commonAppBar(title: "Create a leave request"),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            CommomDropDownButton(
              leaveType: leaveType,
              selectedleaveType: selectedleaveType,
              onChanged: (v) {
                setState(() {
                  selectedleaveType = v.toString();
                });
              },
            ),
            /////////////////////////////
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: GestureDetector(
                onTap: () => selectLeaveDate(
                  context: context,
                  title: "Select leave start date",
                  selectedDate: _startSelectedDate,
                  onDateTimeChanged: (DateTime value) {
                    setState(() {
                      _startSelectedDate = value;
                      final DateTime timeCreate = _startSelectedDate;

                      final DateFormat formatter = DateFormat("MMMM d yyyy");
                      formattedStartDate = formatter.format(timeCreate);
                      print(formattedStartDate);
                      // print(_startSelectedDate);
                    });
                  },
                ),
                child: CommonFieldComponent(
                  enable: false,
                  hintColor: CustomeColors.blackMedium,
                  hintText: formattedStartDate ?? "Start Date ",
                  // controller: titleController,
                  prefixIcon: const Icon(FeatherIcons.calendar),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => selectLeaveDate(
                context: context,
                selectedDate: _endSelectedDate,
                title: "Select leave end date",
                onDateTimeChanged: (DateTime value) {
                  setState(() {
                    _endSelectedDate = value;
                    final DateTime timeCreate = _endSelectedDate;

                    final DateFormat formatter = DateFormat("MMMM d yyyy");
                    formattedEndDate = formatter.format(timeCreate);
                    print(formattedEndDate);
                    print(_endSelectedDate);
                  });
                },
              ),
              child: CommonFieldComponent(
                hintText: formattedEndDate ?? "End Date ",
                enable: false,
                hintColor: CustomeColors.blackMedium,

                // controller: titleController,
                prefixIcon: const Icon(FeatherIcons.calendar),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CommonFieldComponent(
                      hintText: "Leave Reason",
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 20,
                      // maxLength: 1000,
                      controller: reasonController,
                    ),
                  ],
                ),
              ),
            ),
            // Spacer(),
            SafeArea(
              child: CommonButton(
                title: "Submit",
                onTap: () {
                  leaveService.requestLeave(
                      context: context,
                      reason: reasonController.text,
                      leaveType: selectedleaveType,
                      startDate: _startSelectedDate,
                      endDate: _endSelectedDate);
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}

Future<dynamic> selectLeaveDate(
    {BuildContext? context,
    DateTime? selectedDate,
    String? title,
    void Function(DateTime)? onDateTimeChanged}) {
  return showModalBottomSheet(
    backgroundColor: CustomeColors.white,
    context: context!,
    builder: (context) => Column(
      children: [
        Text(title!),
        Expanded(
          child: ScrollDatePicker(

              // indicator: Text("46"),
              viewType: const [],
              options: DatePickerOptions(
                itemExtent: 40,
                backgroundColor: CustomeColors.white.withOpacity(0),
              ),
              scrollViewOptions: const DatePickerScrollViewOptions(
                  mainAxisAlignment: MainAxisAlignment.spaceAround),
              selectedDate: selectedDate!,
              locale: const Locale('en'),
              onDateTimeChanged: onDateTimeChanged!),
        ),
      ],
    ),
  );
}

class CommomDropDownButton extends StatelessWidget {
  const CommomDropDownButton(
      {Key? key,
      this.leaveType,
      this.selectedleaveType,
      this.onChanged,
      this.hintText})
      : super(key: key);
  final String? selectedleaveType;
  final List? leaveType;
  final String? hintText;
  final void Function(Object?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Material(
      // color: CustomeColors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color(0xffDAE1E1))),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          child: DropdownButton(
              style: TextStyle(fontSize: 16, color: CustomeColors.blackMedium),
              dropdownColor: CustomeColors.white,
              isExpanded: true,
              value: selectedleaveType,
              hint: Text(
                hintText ?? "Select leave type",
                style: TextStyle(color: CustomeColors.blackMedium),
              ),
              items: leaveType!
                  .map(
                    (e) =>
                        DropdownMenuItem(value: e, child: Text(e.toString())),
                  )
                  .toList(),
              onChanged: onChanged),
        ),
      ),
    );
  }
}
