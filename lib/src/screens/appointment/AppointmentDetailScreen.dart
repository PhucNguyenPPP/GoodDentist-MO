import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDetailDTO.dart';
import 'package:good_dentist_mobile/src/screens/customer/CustomerDetailScreen.dart';
import 'package:good_dentist_mobile/src/screens/layout/CustomerDetailLayout.dart';
import 'package:intl/intl.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final ApiResponseDTO<ExaminationDetailDTO>? examDetail;
  const AppointmentDetailScreen({super.key, required this.examDetail});

  @override
  State<StatefulWidget> createState() {
    return AppointmentDetailScreenState();
  }
}

class AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
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
                                    const CustomerDetailLayout(
                                      customerId: "aa",
                                      customerName: "aa",
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
                          widget.examDetail!.result!.status == 1
                              ? "Completed"
                              : widget.examDetail!.result!.status == 2
                              ? "Canceled"
                              : widget.examDetail!.result!.status == 3
                              ? "Not yet"
                              : widget.examDetail!.result!.status == 4
                              ? "Overdue"
                              : "Unknown",
                          style: TextStyle(fontSize: 18),
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
                          "Doctor:",
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: Text(
                          widget.examDetail!.result!.dentistSlot.dentist.name,
                          style: TextStyle(fontSize: 18),
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
                          widget.examDetail!.result!.diagnosis,
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
                          "Time:",
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
                            width: constraints.maxWidth * 0.4,
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
                        SizedBox(
                          height: constraints.maxHeight * 0.03,
                        ),
                        Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey,
                            ),
                            width: constraints.maxWidth * 0.25,
                            child: Row(
                              children: [
                                Text(
                                  DateFormat('HH:mm').format((DateTime.parse(
                                      widget.examDetail!.result!.timeStart.toString()))),
                                  style: const TextStyle(fontSize: 18),
                                ),
                                SizedBox(width: constraints.maxWidth * 0.02),
                                const Icon(Icons.watch_later_outlined)
                              ],
                            ))
                      ],
                    ),
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
                          "Duration:",
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: Text(
                          "$durationInMinutes minutes",
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
                          "Note",
                          style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: Text(
                          widget.examDetail!.result!.notes,
                          style: TextStyle(fontSize: 18),
                        )),
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
