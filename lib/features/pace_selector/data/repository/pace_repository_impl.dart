import 'dart:convert';
import 'dart:io';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/http_client.dart';
import '../../../../core/network/network_exception.dart';
import '../models/pace_submission_request.dart';
import 'pace_repository.dart';

class PaceRepositoryImpl implements PaceRepository {
  PaceRepositoryImpl({HttpClient? httpClient})
      : _httpClient = httpClient ?? HttpClient();

  final HttpClient _httpClient;

  @override
  Future<void> submitPace(int paceSeconds) async {
    try {
      final body = jsonEncode(
        PaceSubmissionRequest(paceSeconds: paceSeconds).toJson(),
      );
      final response = await _httpClient.post(
        ApiConstants.postsEndpoint,
        body: body,
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw NetworkServerException(
          'Failed to save pace (status ${response.statusCode}).',
        );
      }
    } on NetworkException {
      rethrow;
    } on SocketException {
      throw const NetworkConnectionException();
    } on HttpException {
      throw const NetworkConnectionException();
    } catch (_) {
      throw const NetworkServerException('Failed to save pace.');
    }
  }
}
