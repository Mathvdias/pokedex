import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pokedex/src/app_config.dart';

import '../../models/response/exception_response.dart';
import '../http_client_interface.dart';

class DioClient implements IRestClient {
  late Dio dio;
  final options = BaseOptions(
    connectTimeout: 500,
    receiveTimeout: 500,
    baseUrl: ApiURL.instance.base(),
  );

  DioClient.withAuthBasic() {
    dio = Dio(options);
    dio.options.contentType = Headers.formUrlEncodedContentType;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.next(options),
        onResponse: (response, handle) => handle.resolve(response),
        onError: (e, handler) => handler.reject(e),
      ),
    );
    dio.interceptors.add(LogInterceptor(responseBody: false));
  }

  @override
  Future<dynamic> get(String url) async {
    try {
      final response = await dio.get(url);
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
