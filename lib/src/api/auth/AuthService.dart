import 'dart:convert';
import 'package:good_dentist_mobile/src/api/ApiConfig.dart';
import 'package:good_dentist_mobile/src/models/LoginResponseDTO.dart';
import 'package:http/http.dart' as http;

class AuthService {

  static Future<LoginResponseDTO> login(String username, String password) async {
    final String baseUrl = ApiConfig.getBaseUrl();
    final url = Uri.parse('$baseUrl/api/login');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return LoginResponseDTO.fromJson(jsonDecode(response.body));
    } else {
      return LoginResponseDTO.fromJson(jsonDecode(response.body));
    }
  }
}