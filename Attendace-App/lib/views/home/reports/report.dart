import 'package:attendance_app/controllers/reports_controller.dart';
import 'package:attendance_app/models/reports_model.dart';
import 'package:attendance_app/utils/colors.dart';
import 'package:attendance_app/utils/constant.dart';
import 'package:attendance_app/views/home/home.dart';
import 'package:attendance_app/views/home/reports/new_report.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:light_modal_bottom_sheet/light_modal_bottom_sheet.dart';

class Reports extends StatelessWidget {
  const Reports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomeColors.white,
      appBar: commonAppBar(title: "Reports"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showMaterialModalBottomSheet(
                        backgroundColor: CustomeColors.white,
                        expand: true,
                        context: context,
                        builder: (context) => const NewReportComponent(),
                      );
                    },
                    child: Text(
                      "CREATE NEW",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: CustomeColors.primary),
                    ),
                  ),
                ],
              ),
              Expanded(
                child:
                    GetBuilder<ReportController>(builder: (reportController) {
                  return ListView.builder(
                      itemCount: reportController.employeeReportsHistory.length,
                      itemBuilder: (contxet, index) {
                        // final reports = reportController
                        //     .employeeReportsHistory[index]
                        //     .weeklyReports[index]
                        //     .month;
                        final List<WeeklyReport> rep = reportController
                            .employeeReportsHistory[index].weeklyReports;
                        final repi = reportController
                            .employeeReportsHistory[index]
                            .weeklyReports[0]
                            .month;
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                tileColor: CustomeColors.primary,
                                title: Text(
                                  repi,
                                  style: TextStyle(color: CustomeColors.white),
                                ),
                                subtitle: Text(
                                  "Total report:${rep.length}",
                                  style: smallTextStyle.copyWith(
                                      color: CustomeColors.white),
                                ),
                                trailing: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      rep.length == 4
                                          ? "Completed"
                                          : "Incomplete",
                                      style: smallTextStyle.copyWith(
                                          color: CustomeColors.yellow),
                                    ),
                                    const Icon(
                                      FeatherIcons.file,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Text(repi),
                            // Column(
                            //   children: rep.map((e) => Text(e.title)).toList(),
                            // )
                          ],
                        );
                      });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
