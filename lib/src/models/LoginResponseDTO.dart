class LoginResponseDTO {
  final bool isSuccess;
  final String? message;
  final String? accessToken;
  LoginResponseDTO({required this.isSuccess, required this.message, required this.accessToken});

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) {
    return LoginResponseDTO(
      isSuccess: json['isSuccess'],
      message: json['message'],
      accessToken: json['accessToken'],
    );
  }
}