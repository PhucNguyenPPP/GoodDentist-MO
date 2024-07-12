import 'package:good_dentist_mobile/src/models/ClinicDTO.dart';

class UserDTO {
  final String? userId;
  final String userName;
  final String name;
  final String dob;
  final String gender;
  final String phoneNumber;
  final String email;
  final String createdDate;
  final String address;
  final bool status;
  final int? roleId;
  final String? avatar;
  final List<ClinicDTO>? clinics;

  UserDTO({
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

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    var clinicsList = json['clinics'] as List<dynamic>?;
    return UserDTO(
      userId: json['userId'] ?? "",
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
      clinics: clinicsList != null
          ? clinicsList
          .map((clinic) => ClinicDTO.fromJson(clinic as Map<String, dynamic>))
          .toList()
          : [],
    );
  }
}
