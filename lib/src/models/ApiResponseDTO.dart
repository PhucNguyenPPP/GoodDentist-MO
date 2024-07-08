class ApiResponseDTO<T> {
  final bool isSuccess;
  final String? message;
  final int statusCode;
  final T result;

  ApiResponseDTO({
    required this.isSuccess,
    required this.message,
    required this.statusCode,
    required this.result,
  });

  factory ApiResponseDTO.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJsonT) {
    return ApiResponseDTO(
      isSuccess: json['isSuccess'],
      message: json['message'],
      statusCode: json['statusCode'],
      result: fromJsonT(json['result'] as Map<String, dynamic>),
    );
  }
}
