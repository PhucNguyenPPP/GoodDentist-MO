import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDetailDTO.dart';
import 'package:good_dentist_mobile/src/screens/customer/CustomerDetailScreen.dart';
import 'package:good_dentist_mobile/src/screens/layout/CustomerDetailLayout.dart';
import 'package:intl/intl.dart';

class ExaminationProfileDetailScreen extends StatefulWidget {
  final ApiResponseDTO<ExaminationDetailDTO>? examDetail;
  const ExaminationProfileDetailScreen({super.key, required this.examDetail});

  @override
  State<StatefulWidget> createState() {
    return ExaminationProfileDetailScreenState();
  }
}

class ExaminationProfileDetailScreenState extends State<ExaminationProfileDetailScreen> {
  @override
  Widget build(BuildContext context) {
    if (widget.examDetail == null || widget.examDetail!.result == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    DateTime timeStart = DateTime.parse(widget.examDetail!.result!.timeStart.toString());
    DateTime timeEnd = DateTime.parse(widget.examDetail!.result!.timeEnd.toString());
    Duration duration = timeEnd.difference(timeStart);
    int durationInMinutes = duration.inMinutes;

    return Scaffold(
        body: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: constraints.maxWidth * 0.05),
                    SizedBox(
                        width: constraints.maxWidth * 0.3,
                        child: const Text(
                          "Full Name:",
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.3,
                        child: Text(
                          widget.examDetail!.result!.customerName,
                          style: const TextStyle(fontSize: 18),
                        )),
                    SizedBox(
                        width: constraints.maxWidth * 0.2,
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CustomerDetailLayout(
                                          customerId: widget.examDetail!.result!.customerId,
                                          customerName: widget.examDetail!.result!.customerName,
                                        )),
                              );
                            },
                            child: const Icon(Icons.portrait_outlined)))
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: constraints.maxWidth * 0.05),
                    SizedBox(
                        width: constraints.maxWidth * 0.3,
                        child: const Text(
                          "Phone:",
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: Text(
                          widget.examDetail!.result!.examinationProfile.customer
                              .phoneNumber,
                          style: const TextStyle(fontSize: 18),
                        )),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: constraints.maxWidth * 0.05),
                    SizedBox(
                        width: constraints.maxWidth * 0.3,
                        child: const Text(
                          "Status:",
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: Text(
                          widget.examDetail!.result!.examinationProfile.status
                              ? "Active"
                              : "Inactive",
                          style: const TextStyle(fontSize: 18),
                        )),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: constraints.maxWidth * 0.05),
                    SizedBox(
                        width: constraints.maxWidth * 0.3,
                        child: const Text(
                          "Dentist:",
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: Text(
                          widget.examDetail!.result!.examinationProfile.dentist.name,
                          style: const TextStyle(fontSize: 18),
                        )),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: constraints.maxWidth * 0.05),
                    SizedBox(
                        width: constraints.maxWidth * 0.3,
                        child: const Text(
                          "Diagnosis:",
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: Text(
                          widget.examDetail!.result!.examinationProfile.diagnosis,
                          style: const TextStyle(fontSize: 18),
                        )),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: constraints.maxWidth * 0.05),
                    SizedBox(
                        width: constraints.maxWidth * 0.3,
                        child: const Text(
                          "Created Date:",
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey,
                            ),
                            width: constraints.maxWidth * 0.37,
                            child: Row(
                              children: [
                                Text(
                                  DateFormat('yyyy-MM-dd').format((DateTime.parse(
                                      widget.examDetail!.result!.timeStart.toString()))),
                                  style: const TextStyle(fontSize: 18),
                                ),
                                SizedBox(width: constraints.maxWidth * 0.02),
                                const Icon(Icons.calendar_month)
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.02),
                Container(
                  height: constraints.maxHeight * 0.01,
                  color: Colors.grey[300],
                ),
              ],
            );
          }),
        ));
  }
}
