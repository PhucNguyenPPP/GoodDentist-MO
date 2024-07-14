import 'package:good_dentist_mobile/src/models/OrderServiceDTO.dart';

class OrderDetailDTO {
  final int orderId;
  final String orderName;
  final int examinationId;
  final DateTime dateTime;
  final double price;
  final bool status;
  final List<OrderServiceDTO> orderServices;

  OrderDetailDTO({
    required this.orderId,
    required this.orderName,
    required this.examinationId,
    required this.dateTime,
    required this.price,
    required this.status,
    required this.orderServices,
  });

  factory OrderDetailDTO.fromJson(Map<String, dynamic> json) {
    return OrderDetailDTO(
      orderId: json['orderId'],
      orderName: json['orderName'],
      examinationId: json['examinationId'],
      dateTime: DateTime.parse(json['dateTime']),
      price: json['price'].toDouble(),
      status: json['status'],
      orderServices: (json['orderServices'] as List)
          .map((service) => OrderServiceDTO.fromJson(service))
          .toList(),
    );
  }
}