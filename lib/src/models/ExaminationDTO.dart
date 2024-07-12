class ExaminationDTO {
  final int examinationId;
  final int examinationProfileId;
  final String dentistId;
  final String dentistName;
  final int dentistSlotId;
  final String customerId;
  final String customerName;
  final String diagnosis;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String notes;
  final int status;

  ExaminationDTO({
    required this.examinationId,
    required this.examinationProfileId,
    required this.dentistId,
    required this.dentistName,
    required this.dentistSlotId,
    required this.customerId,
    required this.customerName,
    required this.diagnosis,
    required this.timeStart,
    required this.timeEnd,
    required this.notes,
    required this.status,
  });

  factory ExaminationDTO.fromJson(Map<String, dynamic> json) {
    return ExaminationDTO(
      examinationId: json['examinationId'],
      examinationProfileId: json['examinationProfileId'],
      dentistId: json['dentistId'],
      dentistName: json['dentistName'] ?? '',
      dentistSlotId: json['dentistSlotId'],
      customerId: json['customerId'],
      customerName: json['customerName'],
      diagnosis: json['diagnosis'],
      timeStart: DateTime.parse(json['timeStart']),
      timeEnd: DateTime.parse(json['timeEnd']),
      notes: json['notes'],
      status: json['status'],
    );
  }
}
