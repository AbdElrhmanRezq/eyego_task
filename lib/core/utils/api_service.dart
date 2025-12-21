import 'package:dio/dio.dart';

class ApiService {
  final String _baseUrl = "https://newsapi.org/v2/";
  final Dio dio;

  ApiService(this.dio);

  Future<Map<String, dynamic>> get({required String endpoint}) async {
    final response = await dio.get('$_baseUrl$endpoint');
    return response.data as Map<String, dynamic>;
  }
}
