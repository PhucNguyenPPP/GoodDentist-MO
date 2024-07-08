import 'dart:convert';
import 'package:good_dentist_mobile/src/api/ApiConfig.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/DentistDTO.dart';
import 'package:good_dentist_mobile/src/models/LoginResponseDTO.dart';
import 'package:http/http.dart' as http;

class DentistService {

  static Future<ApiResponseDTO<DentistDTO>> getDentistInformation(String dentistId) async {
    final String baseUrl = ApiConfig.getBaseUrl();
    final url = Uri.parse('$baseUrl/api/users/user?userId=$dentistId');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      }
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return ApiResponseDTO<DentistDTO>.fromJson(jsonResponse, (json) => DentistDTO.fromJson(json));
    } else {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return ApiResponseDTO<DentistDTO>.fromJson(jsonResponse, (json) => DentistDTO.fromJson(json));
    }
  }
}