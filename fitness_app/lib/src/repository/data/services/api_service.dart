import 'package:dio/dio.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    _dio = Dio();
  }

  Dio get dio => _dio;
}

final ApiService apiService = ApiService();