class OrderDTO {
  int orderId;
  String orderName;
  int examinationId;
  String dateTime;
  double price;
  bool status;

  OrderDTO({
    required this.orderId,
    required this.orderName,
    required this.examinationId,
    required this.dateTime,
    required this.price,
    required this.status,
  });

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(
      orderId: json['orderId'],
      orderName: json['orderName'],
      examinationId: json['examinationId'],
      dateTime: json['dateTime'],
      price: json['price'],
      status: json['status'],
    );
  }
}