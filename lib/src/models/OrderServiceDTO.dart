import 'package:good_dentist_mobile/src/models/ServiceDTO.dart';

class OrderServiceDTO {
  final int orderServiceId;
  final int orderId;
  final int serviceId;
  final double price;
  final int quantity;
  final int status;
  final ServiceDTO service;

  OrderServiceDTO({
    required this.orderServiceId,
    required this.orderId,
    required this.serviceId,
    required this.price,
    required this.quantity,
    required this.status,
    required this.service,
  });

  factory OrderServiceDTO.fromJson(Map<String, dynamic> json) {
    return OrderServiceDTO(
      orderServiceId: json['orderServiceId'],
      orderId: json['orderId'],
      serviceId: json['serviceId'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      status: json['status'],
      service: ServiceDTO.fromJson(json['service']),
    );
  }
}