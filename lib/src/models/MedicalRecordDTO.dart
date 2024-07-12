class MedicalRecordDTO {
  int medicalRecordId;
  int examinationId;
  int recordTypeId;
  String url;
  String notes;
  bool status;
  String recordType;

  MedicalRecordDTO({
    required this.medicalRecordId,
    required this.examinationId,
    required this.recordTypeId,
    required this.url,
    required this.notes,
    required this.status,
    required this.recordType,
  });

  // Factory constructor to create a MedicalRecordDTO from a JSON map
  factory MedicalRecordDTO.fromJson(Map<String, dynamic> json) {
    return MedicalRecordDTO(
      medicalRecordId: json['medicalRecordId'],
      examinationId: json['examinationId'],
      recordTypeId: json['recordTypeId'],
      url: json['url'],
      notes: json['notes'],
      status: json['status'],
      recordType: json['recordType'],
    );
  }
}