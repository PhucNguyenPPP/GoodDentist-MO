import 'package:good_dentist_mobile/src/models/MedicineDTO.dart';

class MedicinePrescriptionDTO {
  int medicinePrescriptionId;
  int medicineId;
  int prescriptionId;
  int quantity;
  double price;
  bool status;
  MedicineDTO medicine;

  MedicinePrescriptionDTO({
    required this.medicinePrescriptionId,
    required this.medicineId,
    required this.prescriptionId,
    required this.quantity,
    required this.price,
    required this.status,
    required this.medicine,
  });

  factory MedicinePrescriptionDTO.fromJson(Map<String, dynamic> json) {
    return MedicinePrescriptionDTO(
      medicinePrescriptionId: json['medicinePrescriptionId'],
      medicineId: json['medicineId'],
      prescriptionId: json['prescriptionId'],
      quantity: json['quantity'],
      price: json['price'],
      status: json['status'],
      medicine: MedicineDTO.fromJson(json['medicine']),
    );
  }
}
