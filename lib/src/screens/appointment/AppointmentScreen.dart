import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/screens/layout/AppointmentDetailLayout.dart';
import 'package:intl/intl.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  late String dateOnlyNow;
  late String dateNow;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    dateOnlyNow = DateFormat('yyyy-MM-dd').format(now);
    dateNow = DateFormat('E').format(now);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1980),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateOnlyNow = DateFormat('yyyy-MM-dd').format(selectedDate);
        dateNow = DateFormat('E').format(selectedDate);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () => _selectDate(context),
          child: Row(
            children: [
              Text(
                '$dateNow, $dateOnlyNow',
                style: const TextStyle(color: Colors.white, wordSpacing: 4),
              ),
              const SizedBox(width: 5),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              )
            ],
          ),
        ),
        backgroundColor: Colors.purple[400],
      ),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const AppointmentDetailLayout()),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 15, left: 15),
                    height: 120,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(width: 0.8, color: Colors.grey))),
                    child: Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.6,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Nguyen Van A",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 3),
                              Text("10:15 - 12:15",
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 3),
                              Text("First Time | Dieu tri tuy",
                                  style: TextStyle(
                                      fontSize: 18,
                                      overflow: TextOverflow.ellipsis))
                            ],
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.05),
                        SizedBox(
                          width: constraints.maxWidth * 0.25,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey, // Set the color here
                                  borderRadius: BorderRadius.circular(
                                      8), // Set the border radius here
                                ),
                                child: const Text("Not yet",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 15, left: 15),
                  height: 120,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 0.8, color: Colors.grey))),
                  child: Row(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.6,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Nguyen Van A",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 3),
                            Text("10:15 - 12:15",
                                style: TextStyle(fontSize: 18)),
                            SizedBox(height: 3),
                            Text("First Time | Dieu tri tuy",
                                style: TextStyle(
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis))
                          ],
                        ),
                      ),
                      SizedBox(width: constraints.maxWidth * 0.05),
                      SizedBox(
                        width: constraints.maxWidth * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color:
                                    Colors.lightGreen, // Set the color here
                                borderRadius: BorderRadius.circular(
                                    8), // Set the border radius here
                              ),
                              child: const Text("Completed",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 15, left: 15),
                  height: 120,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 0.8, color: Colors.grey))),
                  child: Row(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.6,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Nguyen Van A",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 3),
                            Text("10:15 - 12:15",
                                style: TextStyle(fontSize: 18)),
                            SizedBox(height: 3),
                            Text("First Time | Dieu tri tuy",
                                style: TextStyle(
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis))
                          ],
                        ),
                      ),
                      SizedBox(width: constraints.maxWidth * 0.05),
                      SizedBox(
                        width: constraints.maxWidth * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.orange, // Set the color here
                                borderRadius: BorderRadius.circular(
                                    8), // Set the border radius here
                              ),
                              child: const Text("Overdue",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  margin: const EdgeInsets.only(right: 15, left: 15),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 0.8, color: Colors.grey))),
                  child: Row(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.6,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Nguyen Van A",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 3),
                            Text("10:15 - 12:15",
                                style: TextStyle(fontSize: 18)),
                            SizedBox(height: 3),
                            Text("First Time | Dieu tri tuy",
                                style: TextStyle(
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis))
                          ],
                        ),
                      ),
                      SizedBox(width: constraints.maxWidth * 0.05),
                      SizedBox(
                        width: constraints.maxWidth * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.red, // Set the color here
                                borderRadius: BorderRadius.circular(
                                    8), // Set the border radius here
                              ),
                              child: const Text("Cancled",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
