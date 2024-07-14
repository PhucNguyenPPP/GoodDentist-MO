import 'package:flutter/material.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationDetailDTO.dart';
import 'package:good_dentist_mobile/src/screens/order/OrderDetailScreen.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatefulWidget {
  final ApiResponseDTO<ExaminationDetailDTO>? examDetail;

  const OrderScreen({super.key, required this.examDetail});

  @override
  State<StatefulWidget> createState() {
    return OrderScreenState();
  }
}

class OrderScreenState extends State<OrderScreen> {
  final NumberFormat _priceFormat = NumberFormat.currency(locale: 'vi_VND', symbol: '');
  @override
  Widget build(BuildContext context) {
    if (widget.examDetail == null || widget.examDetail!.result == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (widget.examDetail!.result!.orders.isEmpty) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/NoData.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: widget.examDetail!.result!.orders.length,
        itemBuilder: (context, index) {
          final order = widget.examDetail!.result!.orders[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderDetailScreen(orderId: order.orderId),
                ),
              );
            },
            child: Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 0.8, color: Colors.grey),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          order.orderName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          DateFormat('yyyy-MM-dd  |  HH:mm').format(
                            DateTime.parse(order.dateTime.toString()),
                          ),
                          style: const TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      '${_priceFormat.format(order.price.toInt())} VND',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
