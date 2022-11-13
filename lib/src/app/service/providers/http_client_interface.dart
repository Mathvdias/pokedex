abstract class IRestClient {
  Future<dynamic> get(String url, {Map<String, dynamic>? queries});
}
