import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomerDetailScreen extends StatefulWidget {
  const CustomerDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CustomerDetailScreenState();
  }
}

class _CustomerDetailScreenState extends State<CustomerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(height: constraints.maxHeight * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                      'https://th.bing.com/th/id/OIP.2AhD70xJ9FbrlEIpX_jrxgHaHa?rs=1&pid=ImgDetMain',
                      height: constraints.maxHeight * 0.2),
                ),
              ],
            ),
            SizedBox(height: constraints.maxHeight * 0.02),
            Container(
              height: constraints.maxHeight * 0.01,
              color: Colors.grey[300],
            ),
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
                  width: constraints.maxWidth * 0.5,
                    child: const Text(
                  "Nguyen Van A",
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
                      "Gender:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(
                    width: constraints.maxWidth * 0.5,
                    child: const Text(
                      "Male",
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
                      "Birthdate:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(
                    width: constraints.maxWidth * 0.5,
                    child: const Text(
                      "08/06/2000",
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
                      "Email:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(
                    width: constraints.maxWidth * 0.5,
                    child: const Text(
                      "abc1234@gmail.com",
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(
                    width: constraints.maxWidth * 0.5,
                    child: const Text(
                      "0123698536",
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
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(

                    width: constraints.maxWidth * 0.5,
                    child: const Text(
                      "201, Nguyen Cu Trinh, District 1, Ho Chi Minh City",
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
                      "Created Date:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                SizedBox(width: constraints.maxWidth * 0.1),
                SizedBox(

                    width: constraints.maxWidth * 0.5,
                    child: const Text(
                      "08/06/2024",
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
