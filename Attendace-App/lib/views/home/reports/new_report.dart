import 'package:attendance_app/components/common_textfield.dart';
import 'package:attendance_app/services/reports_service.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/views/dashboard/splash.dart';
import 'package:attendance_app/views/home/leave/leave.dart';
import 'package:flutter/material.dart';

class NewReportComponent extends StatefulWidget {
  const NewReportComponent({super.key});

  @override
  State<NewReportComponent> createState() => _NewReportComponentState();
}

class _NewReportComponentState extends State<NewReportComponent> {
  final ReportService reportService = ReportService();
  List months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  List weeks = [
    "Week One",
    "Week Two",
    "Week Three",
    "Week Four",
  ];
  String? selectedMonth;
  String? selectedWeek;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.cancel, color: CustomeColors.grey),
                ),
              ),
              const Text(
                "Create New Report",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              CommomDropDownButton(
                hintText: "Select month",
                leaveType: months,
                selectedleaveType: selectedMonth,
                onChanged: (v) {
                  setState(() {
                    selectedMonth = v.toString();
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CommomDropDownButton(
                  hintText: "Select Week",
                  leaveType: weeks,
                  selectedleaveType: selectedWeek,
                  onChanged: (v) {
                    setState(() {
                      selectedWeek = v.toString();
                    });
                  },
                ),
              ),

              CommonFieldComponent(
                hintText: "Report Title",
                keyboardType: TextInputType.multiline,
                controller: titleController,
              ),
              const SizedBox(height: 20),

              CommonFieldComponent(
                hintText: "Body",
                keyboardType: TextInputType.multiline,
                minLines: 4,
                maxLines: 20,
                controller: bodyController,
              ),
              const SizedBox(height: 100),
              // Spacer(),
              SafeArea(
                child: CommonButton(
                  title: "Submit",
                  onTap: () {
                    reportService
                        .createReport(
                      context: context,
                      title: titleController.text,
                      month: selectedMonth,
                      week: selectedWeek,
                      body: bodyController.text,
                    )
                        .then((value) {
                      Navigator.pop(context);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
