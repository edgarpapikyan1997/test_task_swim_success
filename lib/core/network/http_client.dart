import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class HttpClient {
  HttpClient({http.Client? client, String? baseUrl})
      : _client = client ?? http.Client(),
        _baseUrl = baseUrl ?? ApiConstants.jsonPlaceholderBaseUrl;

  final http.Client _client;
  final String _baseUrl;

  Uri uri(String path) => Uri.parse('$_baseUrl$path');

  Future<http.Response> get(String path) => _client.get(uri(path));

  Future<http.Response> post(String path, {Object? body}) =>
      _client.post(
        uri(path),
        headers: const {'Content-Type': 'application/json'},
        body: body,
      );

  void dispose() => _client.close();
}
