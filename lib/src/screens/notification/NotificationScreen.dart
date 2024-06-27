import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NotificationScreenState();
  }
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Notification'),
          ],
        ),
        backgroundColor: Colors.purple[400]),
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                  Container(
                    height: 90,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(225, 175, 209, 0.3),
                        border: Border(bottom: BorderSide(width: 0.8, color: Colors.black))),
                    child: Row(
                      children: [
                        SizedBox(width: constraints.maxWidth * 0.05),
                        SizedBox(
                          width: constraints.maxWidth * 0.8,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                  Text("You have a new appointment with Mr.Nguyen Minh Phuc", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(height: 3),
                              Text("15:00, 06/06/2024", style: TextStyle(fontSize: 18))
                            ],
                          ),
                        ),
                        SizedBox(width: constraints.maxWidth * 0.05),
                        const Icon(Icons.fiber_manual_record, color: Color.fromRGBO(173, 136, 198, 1))
                      ],
                    ),
                  ),
                Container(
                  height: 90,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(bottom: BorderSide(width: 0.8, color: Colors.black))),
                  child: Row(
                    children: [
                      SizedBox(width: constraints.maxWidth * 0.05),
                      SizedBox(
                        width: constraints.maxWidth * 0.8,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("You have a new appointment with Mr.Nguyen Minh Hoang", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            SizedBox(height: 3),
                            Text("12:00, 05/06/2024", style: TextStyle(fontSize: 18))
                          ],
                        ),
                      ),
                      SizedBox(width: constraints.maxWidth * 0.05),
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