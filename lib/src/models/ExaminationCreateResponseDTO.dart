class ExaminationCreateResponseDTO {
  final List<String> message;
  final int statusCode;
  final bool isSuccess;

  ExaminationCreateResponseDTO({
    required this.isSuccess,
    required this.statusCode,
    required this.message,
  });

  factory ExaminationCreateResponseDTO.fromJson(Map<String, dynamic> json) {
    return ExaminationCreateResponseDTO(
      isSuccess: json['isSuccess'] ?? false,
      statusCode: json['statusCode'] ?? 400,
      message: List<String>.from(json['message'] ?? []),
    );
  }
}