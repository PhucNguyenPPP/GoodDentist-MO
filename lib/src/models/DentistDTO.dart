import 'package:good_dentist_mobile/src/models/ClinicDTO.dart';

class DentistDTO {
  final String userId;
  final String userName;
  final String name;
  final String dob;
  final String gender;
  final String phoneNumber;
  final String email;
  final String createdDate;
  final String address;
  final bool status;
  final int roleId;
  final String avatar;
  final List<ClinicDTO> clinics;

  DentistDTO({
    required this.userId,
    required this.userName,
    required this.name,
    required this.dob,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.createdDate,
    required this.address,
    required this.status,
    required this.roleId,
    required this.avatar,
    required this.clinics,
  });

  factory DentistDTO.fromJson(Map<String, dynamic> json) {
    return DentistDTO(
      userId: json['userId'],
      userName: json['userName'],
      name: json['name'],
      dob: json['dob'],
      gender: json['gender'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      createdDate: json['createdDate'],
      address: json['address'],
      status: json['status'],
      roleId: json['roleId'],
      avatar: json['avatar'],
      clinics: (json['clinics'] as List<dynamic>)
          .map((clinic) => ClinicDTO.fromJson(clinic as Map<String, dynamic>))
          .toList(),
    );
  }
}
