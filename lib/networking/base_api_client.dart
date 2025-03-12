import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter_training_project/networking/api_interceptors.dart';

class BaseApiClient {
  final Dio _dio;

  BaseApiClient({required String baseUrl})
    : _dio = Dio(BaseOptions(baseUrl: baseUrl)) {
    _dio.interceptors.add(ApiInterceptor());
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(endpoint, queryParameters: queryParameters);
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(endpoint, data: data);
    } catch (e) {
      rethrow;
    }
  }

  /// Upload files
  Future<Response?> uploadImageFromBytes(
    Uint8List bytes,
    String fileName,
  ) async {
    try {
      final response = await _dio.post(
        '/files/upload',
        data: FormData.fromMap({
          'file': MultipartFile.fromBytes(bytes, filename: fileName),
        }),
        options: Options(contentType: 'multipart/form-data'),
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
