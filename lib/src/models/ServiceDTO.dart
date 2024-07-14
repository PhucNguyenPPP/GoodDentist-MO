class ServiceDTO {
  final int serviceId;
  final String serviceName;
  final String description;
  final double price;
  final bool status;

  ServiceDTO({
    required this.serviceId,
    required this.serviceName,
    required this.description,
    required this.price,
    required this.status,
  });

  factory ServiceDTO.fromJson(Map<String, dynamic> json) {
    return ServiceDTO(
      serviceId: json['serviceId'],
      serviceName: json['serviceName'],
      description: json['description'],
      price: json['price'].toDouble(),
      status: json['status'],
    );
  }
}