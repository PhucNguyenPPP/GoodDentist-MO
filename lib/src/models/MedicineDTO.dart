class MedicineDTO {
  int medicineId;
  String medicineName;
  String type;
  int quantity;
  String description;
  double price;
  bool status;

  MedicineDTO({
    required this.medicineId,
    required this.medicineName,
    required this.type,
    required this.quantity,
    required this.description,
    required this.price,
    required this.status,
  });

  factory MedicineDTO.fromJson(Map<String, dynamic> json) {
    return MedicineDTO(
      medicineId: json['medicineId'],
      medicineName: json['medicineName'],
      type: json['type'],
      quantity: json['quantity'],
      description: json['description'],
      price: json['price'],
      status: json['status'],
    );
  }
}
