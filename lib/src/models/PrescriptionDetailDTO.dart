import 'package:good_dentist_mobile/src/models/MedicinePrescriptionDTO.dart';

class PrescriptionDetailDTO {
  int prescriptionId;
  String dateTime;
  String note;
  double total;
  int examinationId;
  bool status;
  List<MedicinePrescriptionDTO> medicinePrescriptions;

  PrescriptionDetailDTO({
    required this.prescriptionId,
    required this.dateTime,
    required this.note,
    required this.total,
    required this.examinationId,
    required this.status,
    required this.medicinePrescriptions,
  });

  factory PrescriptionDetailDTO.fromJson(Map<String, dynamic> json) {
    return PrescriptionDetailDTO(
      prescriptionId: json['prescriptionId'],
      dateTime: json['dateTime'],
      note: json['note'],
      total: json['total'],
      examinationId: json['examinationId'],
      status: json['status'],
      medicinePrescriptions: (json['medicinePrescriptions'] as List)
          .map((i) => MedicinePrescriptionDTO.fromJson(i))
          .toList(),
    );
  }
}
