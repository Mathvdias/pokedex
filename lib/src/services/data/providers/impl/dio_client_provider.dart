import 'dart:async';

import 'package:dio/dio.dart';

import '../http_client_interface.dart';
class DioClient implements IRestClient {
  DioClient(this.dio);
  late Dio dio;
  final options = BaseOptions(
    receiveTimeout: 1500,
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
    final response = await dio.get(url);
    return response.data;
  }
}
