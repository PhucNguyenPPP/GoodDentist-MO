class PrescriptionDTO {
  int prescriptionId;
  String dateTime;
  String note;
  double total;
  int examinationId;
  bool status;

  PrescriptionDTO({
    required this.prescriptionId,
    required this.dateTime,
    required this.note,
    required this.total,
    required this.examinationId,
    required this.status,
  });

  factory PrescriptionDTO.fromJson(Map<String, dynamic> json) {
    return PrescriptionDTO(
      prescriptionId: json['prescriptionId'],
      dateTime: json['dateTime'],
      note: json['note'],
      total: json['total'],
      examinationId: json['examinationId'],
      status: json['status'],
    );
  }
}