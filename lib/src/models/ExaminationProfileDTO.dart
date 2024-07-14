import 'package:good_dentist_mobile/src/models/UserDTO.dart';

class ExaminationProfileDTO {
  int examinationProfileId;
  String customerId;
  String dentistId;
  DateTime date;
  String diagnosis;
  bool status;
  UserDTO customer;
  UserDTO dentist;

  ExaminationProfileDTO({
    required this.examinationProfileId,
    required this.customerId,
    required this.dentistId,
    required this.date,
    required this.diagnosis,
    required this.status,
    required this.customer,
    required this.dentist,
  });

  factory ExaminationProfileDTO.fromJson(Map<String, dynamic> json) {
    return ExaminationProfileDTO(
      examinationProfileId: json['examinationProfileId'],
      customerId: json['customerId'],
      dentistId: json['dentistId'],
      date: DateTime.parse(json['date']),
      diagnosis: json['diagnosis'],
      status: json['status'],
      customer: UserDTO.fromJson(json['customer']),
      dentist:  UserDTO.fromJson(json['dentist']),
    );
  }
}
