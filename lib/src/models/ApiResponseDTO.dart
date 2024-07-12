class ApiResponseDTO<T> {
  final String message;
  final int statusCode;
  final bool isSuccess;
  final T? result;

  ApiResponseDTO({
    required this.message,
    required this.statusCode,
    required this.isSuccess,
    this.result,
  });

  factory ApiResponseDTO.fromJson(Map<String, dynamic> json, T Function(dynamic) fromJsonT) {
    return ApiResponseDTO<T>(
      message: json['message'],
      statusCode: json['statusCode'],
      isSuccess: json['isSuccess'],
      result: json['result'] != null ? fromJsonT(json['result']) : null,
    );
  }
}
