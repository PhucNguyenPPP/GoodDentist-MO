import 'dart:convert';

import 'package:good_dentist_mobile/src/api/ApiConfig.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/DentistSlotDTO.dart';
import 'package:http/http.dart' as http;

class DentistSlotService {

  static Future<ApiResponseDTO<List<DentistSlotDTO>>> getDentistSlotOfDentistByDate(String dentistId, String clinicId, String date) async {
    final String baseUrl = ApiConfig.getBaseUrl();
    final url = Uri.parse('$baseUrl/dentist/date?clinicId=$clinicId&dentistId=$dentistId&selectedDate=$date');
    final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['result'] != null && jsonResponse['result'] is List) {
        List<DentistSlotDTO> userList = (jsonResponse['result'] as List)
            .map((item) => DentistSlotDTO.fromJson(item))
            .toList();
        return ApiResponseDTO<List<DentistSlotDTO>>(
          isSuccess: true,
          statusCode: 200,
          message: 'Success',
          result: userList,
        );
      } else {
        return ApiResponseDTO<List<DentistSlotDTO>>(
          isSuccess: false,
          statusCode: response.statusCode,
          message: 'No data found',
          result: [],
        );
      }
    } else {
      return ApiResponseDTO<List<DentistSlotDTO>>(
        isSuccess: false,
        statusCode: response.statusCode,
        message: 'Failed to fetch data',
        result: [],
      );
    }
  }
}