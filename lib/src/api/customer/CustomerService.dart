import 'dart:convert';
import 'package:good_dentist_mobile/src/api/ApiConfig.dart';
import 'package:good_dentist_mobile/src/models/ApiResponseDTO.dart';
import 'package:good_dentist_mobile/src/models/UserDTO.dart';
import 'package:http/http.dart' as http;

class CustomerService {
  static Future<ApiResponseDTO<List<UserDTO>>?> getCustomerList(String? dentistId) async {
    if (dentistId == null) {
      throw Exception('Dentist ID is null');
    }

    final String baseUrl = ApiConfig.getBaseUrl();
    final url = Uri.parse('$baseUrl/customers/denitst?dentistId=$dentistId'); // Corrected 'denitst' to 'dentist'
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['result'] != null && jsonResponse['result'] is List) {
          List<UserDTO> userList = (jsonResponse['result'] as List)
              .map((item) => UserDTO.fromJson(item))
              .toList();
          return ApiResponseDTO<List<UserDTO>>(
            isSuccess: true,
            statusCode: 200,
            message: 'Success',
            result: userList,
          );
        } else {
          return ApiResponseDTO<List<UserDTO>>(
            isSuccess: false,
            statusCode: response.statusCode,
            message: 'No data found',
            result: [],
          );
        }
      } else {
        return ApiResponseDTO<List<UserDTO>>(
          isSuccess: false,
          statusCode: response.statusCode,
          message: 'Failed to fetch data',
          result: [],
        );
      }
  }

  static Future<ApiResponseDTO<List<UserDTO>>?> searchCustomerList(String? dentistId, String searchValue) async {
    if (dentistId == null) {
      throw Exception('Dentist ID is null');
    }

    final String baseUrl = ApiConfig.getBaseUrl();
    final url = Uri.parse('$baseUrl/customers/denitst?dentistId=$dentistId&search=$searchValue'); // Corrected 'denitst' to 'dentist'
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['result'] != null && jsonResponse['result'] is List) {
        List<UserDTO> userList = (jsonResponse['result'] as List)
            .map((item) => UserDTO.fromJson(item))
            .toList();
        return ApiResponseDTO<List<UserDTO>>(
          isSuccess: true,
          statusCode: 200,
          message: 'Success',
          result: userList,
        );
      } else {
        return ApiResponseDTO<List<UserDTO>>(
          isSuccess: false,
          statusCode: response.statusCode,
          message: 'No data found',
          result: [],
        );
      }
    } else {
      return ApiResponseDTO<List<UserDTO>>(
        isSuccess: false,
        statusCode: response.statusCode,
        message: 'Failed to fetch data',
        result: [],
      );
    }
  }

  static Future<ApiResponseDTO<UserDTO>> getCustomerInfo(String? customerId) async {
    if (customerId == null) {
      throw Exception('Customer ID is null');
    }

    final String baseUrl = ApiConfig.getBaseUrl();
    final url = Uri.parse('$baseUrl/customers/customer/$customerId');
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return ApiResponseDTO<UserDTO>.fromJson(jsonResponse, (json) => UserDTO.fromJson(json));
      } else {
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      return ApiResponseDTO<UserDTO>.fromJson(
          jsonResponse, (json) => UserDTO.fromJson(json));
    }
  }
}
