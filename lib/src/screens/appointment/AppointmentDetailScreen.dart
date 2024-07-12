import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/screens/customer/CustomerDetailScreen.dart';
import 'package:good_dentist_mobile/src/screens/layout/CustomerDetailLayout.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return AppointmentDetailScreenState();
  }
}

class AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(
                    width: constraints.maxWidth * 0.3,
                    child: const Text(
                      "Nguyen Van A",
                      style: TextStyle(fontSize: 18),
                    )),
                SizedBox(
                    width: constraints.maxWidth * 0.2,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const CustomerDetailLayout(customerId: "aa", customerName: "aa",)),
                          );
                        },
                        child: const Icon(Icons.portrait_outlined)
                    )
                )
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(
                    width: constraints.maxWidth * 0.5,
                    child: const Text(
                      "0123456789",
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
                      "Status:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(
                    width: constraints.maxWidth * 0.5,
                    child: const Text(
                      "Not yet",
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(
                    width: constraints.maxWidth * 0.5,
                    child: const Text(
                      "Huynh Van Tien",
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
                      "Content:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(
                    width: constraints.maxWidth * 0.5,
                    child: const Text(
                      "Dieu tri tuy",
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
                      "Time:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                            const Text(
                              "2024/02/06",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(width: constraints.maxWidth * 0.02),
                            const Icon(Icons.calendar_month)
                          ],
                        )
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03,),
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey,
                        ),
                        width: constraints.maxWidth * 0.25,
                        child: Row(
                          children: [
                            const Text(
                              "13:15",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(width: constraints.maxWidth * 0.02),
                            const Icon(Icons.watch_later_outlined)
                          ],
                        )
                    )
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(

                    width: constraints.maxWidth * 0.5,
                    child: const Text(
                      "15 minutes",
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
                      "Note",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(

                    width: constraints.maxWidth * 0.5,
                    child: const Text(
                      "dang met lam rooi khong bik ghi note gi nua nen vay thoi nha thong cam",
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