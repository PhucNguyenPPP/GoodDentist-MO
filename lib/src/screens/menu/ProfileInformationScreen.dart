import 'package:flutter/material.dart';

class ProfileInformationScreen extends StatefulWidget {
  const ProfileInformationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileInformationScreenState();
  }
}

class _ProfileInformationScreenState extends State<ProfileInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[400],
          title: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Profile Information'),
              ]),
        ),
        body: Center(
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                SizedBox(height: constraints.maxHeight * 0.02),
                Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    margin: const EdgeInsets.only(right: 15, left: 15),
                    decoration: (const BoxDecoration(
                        border: Border(
                            bottom:
                            BorderSide(width: 0.8, color: Colors.black)))),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                              'https://th.bing.com/th/id/OIP.2AhD70xJ9FbrlEIpX_jrxgHaHa?rs=1&pid=ImgDetMain',
                              height: constraints.maxHeight * 0.08),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.05),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: constraints.maxWidth * 0.7,
                              child: const Text(
                                "Dr. Hoang Van Tien",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: constraints.maxHeight * 0.01,
                            ),
                            SizedBox(
                              width: constraints.maxWidth * 0.7,
                              child: const Text(
                                "hoangvantien34345@gmail.com",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
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
                          "User Name:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: const Text(
                          "vantien",
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
                          "Role:",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(width: constraints.maxWidth * 0.1),
                    SizedBox(
                        width: constraints.maxWidth * 0.5,
                        child: const Text(
                          "Doctor",
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
