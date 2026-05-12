import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intercepted_http/intercepted_http.dart';

import '../http_client_interface.dart';

class PokedexHttpClient implements IRestClient {
  late final http.Client _client;

  PokedexHttpClient()
      : _client = InterceptedHttp(
          interceptors: [_LogInterceptor(), _RetryInterceptor()],
          timeout: const Duration(seconds: 15),
          maxRetries: 2,
        );

  @override
  Future<dynamic> get(String url) async {
    final response = await _client.get(Uri.parse(url));
    return jsonDecode(response.body);
  }
}

class _LogInterceptor extends HttpInterceptor {
  @override
  Future<void> onRequest(http.Request request) async {
    log('→ ${request.method} ${request.url}');
  }

  @override
  Future<http.Response> onResponse(
    http.Response response,
    http.Request request,
  ) async {
    log('← ${response.statusCode} ${request.url}');
    return response;
  }

  @override
  Future<void> onError(http.Response response, http.Request request) async {
    log('✗ ${response.statusCode} ${request.url}: ${response.body}');
  }
}

class _RetryInterceptor extends HttpInterceptor {
  @override
  Future<Duration?> shouldRetry(
    Object error,
    StackTrace stackTrace,
    http.Request request, {
    http.Response? response,
  }) async {
    // retry only on network/timeout errors, not on HTTP errors
    if (response != null) return null;
    return const Duration(milliseconds: 500);
  }
}
