class ClinicDTO {
  final String clinicId;
  final String clinicName;
  final String address;
  final String phoneNumber;
  final String email;
  final bool status;

  ClinicDTO({
    required this.clinicId,
    required this.clinicName,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.status,
  });

  factory ClinicDTO.fromJson(Map<String, dynamic> json) {
    return ClinicDTO(
      clinicId: json['clinicId'],
      clinicName: json['clinicName'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      status: json['status'],
    );
  }
}