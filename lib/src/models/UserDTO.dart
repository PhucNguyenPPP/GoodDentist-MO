import 'package:good_dentist_mobile/src/models/ClinicDTO.dart';
import 'package:good_dentist_mobile/src/models/ExaminationProfileDTO.dart';

class UserDTO {
  final String? userId;
  final String? customerId;
  final String? userName;
  final String name;
  final String dob;
  final String gender;
  final String phoneNumber;
  final String email;
  final String createdDate;
  final String address;
  final String? anamnesis;
  final bool status;
  final int? roleId;
  final String? avatar;
  final List<ClinicDTO>? clinics;
  final List<ExaminationProfileDTO>? examinationProfiles;

  UserDTO({
    required this.userId,
    required this.customerId,
    required this.userName,
    required this.name,
    required this.dob,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.createdDate,
    required this.address,
    required this.anamnesis,
    required this.status,
    required this.roleId,
    required this.avatar,
    required this.clinics,
    required this.examinationProfiles
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    var clinicsList = json['clinics'] as List<dynamic>?;
    var examinationProfileList = json['examinationProfiles'] as List<dynamic>?;
    return UserDTO(
      userId: json['userId'] ?? "",
      customerId: json['customerId'] ?? "",
      userName: json['userName'] ?? "",
      name: json['name'],
      dob: json['dob'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      createdDate: json['createdDate'],
      address: json['address'],
      anamnesis: json['anamnesis'] ?? "",
      status: json['status'],
      roleId: json['roleId'] ?? 0,
      avatar: json['avatar'],
      clinics: clinicsList != null
          ? clinicsList
          .map((clinic) => ClinicDTO.fromJson(clinic as Map<String, dynamic>))
          .toList()
          : [],
      examinationProfiles: examinationProfileList != null
          ? examinationProfileList
          .map((examinationProfile) =>
          ExaminationProfileDTO.fromJson(examinationProfile as Map<String, dynamic>))
          .toList()
          : [],
    );
  }
}
