import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:good_dentist_mobile/src/models/PostDTO.dart';
import 'package:good_dentist_mobile/src/screens/layout/CustomerDetailLayout.dart';

class MyCustomerScreen extends StatefulWidget {
  const MyCustomerScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyCustomerScreenState();
  }
}

class _MyCustomerScreenState extends State<MyCustomerScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: AppBar().preferredSize.height * 0.7,
                  child: TextField(
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: "Search by name, id, phone",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: AppBar().preferredSize.height * 0.7 * 0.1,
                            horizontal:
                                AppBar().preferredSize.height * 0.7 * 0.3)),
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              )
            ],
          ),
          backgroundColor: Colors.purple[400]),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                for (int i = 0; i < 10; i++)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const CustomerDetailLayout()),
                      );
                    },
                    child: Container(
                      height: 90,
                      margin: const EdgeInsets.only(right: 15, left: 15),
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0.8, color: Colors.grey))),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                                'https://th.bing.com/th/id/OIP.2AhD70xJ9FbrlEIpX_jrxgHaHa?rs=1&pid=ImgDetMain',
                                height: 30),
                          ),
                          SizedBox(width: constraints.maxWidth * 0.1),
                          SizedBox(
                            width: constraints.maxWidth * 0.6,
                            child: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Nguyen Van A", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                SizedBox(height: 3),
                                Text("0123456789", style: TextStyle(fontSize: 18))
                              ],
                            ),
                          ),
                          SizedBox(width: constraints.maxWidth * 0.05),
                          const Icon(Icons.more_horiz)
                        ],
                      ),
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