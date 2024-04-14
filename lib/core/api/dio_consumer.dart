import 'package:dio/dio.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/error/exceptions.dart';
import 'api_consumer.dart';

class DioConsumer extends ApiConsumer {
  final _dio = Dio();

  @override
  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await _dio.get(path, queryParameters: queryParameters);

      return response.data;
    } on DioException catch (e) {
      handelExceptions(e);
    }
  }

  @override
  Future<dynamic> delete(String path, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.delete(path, data: body);
      return response.data;
    } on DioException catch (e) {
      handelExceptions(e);
    }
  }

  @override
  Future<dynamic> patch(String path, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.patch(path, data: body);
      return response.data;
    } on DioException catch (e) {
      handelExceptions(e);
    }
  }

  @override
  Future<dynamic> post(String path, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.post(path, data: body);
      return response.data;
    } on DioException catch (e) {
      handelExceptions(e);
    }
  }

  @override
  Future<dynamic> put(String path, {Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.put(path, data: body);
      return response.data;
    } on DioException catch (e) {
      handelExceptions(e);
    }
  }
}
