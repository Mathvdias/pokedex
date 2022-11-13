import 'dart:developer';

import 'package:dio/dio.dart';

import '../../models/response/exception_response.dart';
import '../http_client_interface.dart';

class DioClient implements IRestClient {
  final options = BaseOptions(
    connectTimeout: 1000,
    receiveTimeout: 1000,
  );
  late Dio dio;

  @override
  Future<dynamic> get(String url, {Map<String, dynamic>? queries}) async {
    try {
      final response = await dio.get(url, queryParameters: queries);
      if (response.statusCode == 404) {
        inspect(response.statusMessage);
        throw ExceptionResponse(
          statusCode: 404,
          message: response.statusMessage ?? "Não encontrado",
        );
      }
      if (response.statusCode == 400) {
        inspect(response.statusMessage);
        throw ExceptionResponse(
            message: response.statusMessage ?? "Bad request", statusCode: 400);
      }
      inspect(response.data);
      return response.data;
    } on DioError catch (e) {
      inspect(e);
      throw ExceptionResponse(
          message: "Não foi possivel realizar requisição", statusCode: 500);
    }
  }
}
