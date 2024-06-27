import 'package:flutter/material.dart';

class ClinicInformationScreen extends StatefulWidget {
  const ClinicInformationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClinicInformationScreenState();
  }
}

class _ClinicInformationScreenState extends State<ClinicInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[400],
        title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Clinic Information'),
            ]),
      ),
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
                          "Clinic Name:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: const Text(
                          "Very Good Clinic",
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
                          "Address:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: const Text(
                          "67 Huynh Van Banh, P.17, Phu Nhuan, Tp Ho Chi Minh",
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
                          "Phone:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: const Text(
                          "0125879658",
                          style: TextStyle(fontSize: 18),
                        )),
                  ],
                ),
              ],
            );
          }),
        ));
  }
}
