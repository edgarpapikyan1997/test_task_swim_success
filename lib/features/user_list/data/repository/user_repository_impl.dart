import 'dart:convert';
import 'dart:io';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/http_client.dart';
import '../../../../core/network/network_exception.dart';
import '../models/user_model.dart';
import 'user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  final HttpClient _httpClient;

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _httpClient.get(ApiConstants.usersEndpoint);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw NetworkServerException(
          'Failed to load users (status ${response.statusCode}).',
        );
      }

      final decoded = jsonDecode(response.body);
      if (decoded is! List) {
        throw const NetworkParseException();
      }

      return decoded
          .cast<Map<String, dynamic>>()
          .map(UserModel.fromJson)
          .toList();
    } on NetworkException {
      rethrow;
    } on FormatException {
      throw const NetworkParseException();
    } on SocketException {
      throw const NetworkConnectionException();
    } on HttpException {
      throw const NetworkConnectionException();
    } catch (_) {
      throw const NetworkServerException('Failed to load users.');
    }
  }
}
