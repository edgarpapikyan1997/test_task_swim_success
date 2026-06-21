sealed class NetworkException implements Exception {
  const NetworkException(this.message);

  final String message;

  @override
  String toString() => message;
}

final class NetworkConnectionException extends NetworkException {
  const NetworkConnectionException([
    super.message = 'Unable to connect. Please check your network.',
  ]);
}

final class NetworkServerException extends NetworkException {
  const NetworkServerException([
    super.message = 'Something went wrong on the server.',
  ]);
}

final class NetworkParseException extends NetworkException {
  const NetworkParseException([
    super.message = 'Unable to read the server response.',
  ]);
}
