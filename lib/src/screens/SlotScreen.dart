import 'package:flutter/material.dart';
class SlotScreen extends StatefulWidget {
  const SlotScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SlotScreenState();
  }
}

class _SlotScreenState extends State<SlotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Slot'),
            ],
          ),
          backgroundColor: Colors.purple[400]),
    );
  }
}
