import 'package:iserve/src/src.dart';

class AppExceptionHandler {
  static AppException handle(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    final backendMessage = _extractBackendMessage(data);
    final backendStatus = _extractBackendStatus(data);

    final code = backendStatus ?? statusCode;

    if (backendMessage != null && backendMessage.trim().isNotEmpty) {
      return ServerException(backendMessage);
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return TimeoutException(
          '⏱ Connection timeout — please check your internet connection.',
        );
      case DioExceptionType.sendTimeout:
        return TimeoutException(
          '📤 Send timeout — request took too long to reach the server.',
        );
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          '📥 Receive timeout — the server took too long to respond.',
        );
      case DioExceptionType.badResponse:
        final message = _mapStatusCodeToMessage(code, data);
        switch (code) {
          case 401:
            return UnauthorizedException(message);
          case 422:
            return ValidationException(message);
          default:
            return ServerException(message);
        }
      case DioExceptionType.cancel:
        return NetworkException('❌ Request was cancelled.');
      case DioExceptionType.badCertificate:
        return NetworkException(
          '🔒 Bad SSL certificate — secure connection could not be verified.',
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          '🌐 No internet connection — please check your network.',
        );
      case DioExceptionType.unknown:
        return UnknownException('⚠️ Unexpected error — ${e.message}');
    }
  }

  /// Extract the backend status from response body
  static int? _extractBackendStatus(dynamic data) {
    if (data is Map && data.containsKey('status')) {
      final value = data['status'];
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
    }
    return null;
  }

  static String? _extractBackendMessage(dynamic data) {
    if (data == null) return null;

    if (data is String) return data;
    if (data is List) return data.join('\n');

    if (data is Map) {
      final possibleKeys = [
        'error',
        'errors',
        'message',
        'msg',
        'detail',
        'data',
      ];
      for (final key in possibleKeys) {
        if (data.containsKey(key)) {
          final value = data[key];
          final extracted = _extractBackendErrors(value);
          if (extracted.isNotEmpty) return extracted;
        }
      }

      for (final entry in data.entries) {
        if (entry.value is Map || entry.value is List) {
          final nested = _extractBackendMessage(entry.value);
          if (nested != null && nested.isNotEmpty) return nested;
        }
      }
    }

    return null;
  }

  static String _extractBackendErrors(dynamic error) {
    if (error == null) return '';
    if (error is String) return error;
    if (error is List && error.isNotEmpty) return error.join('\n');

    if (error is Map) {
      final buffer = StringBuffer();
      error.forEach((key, value) {
        if (value is List && value.isNotEmpty) {
          for (final msg in value) {
            buffer.writeln('• $msg');
          }
        } else if (value is String) {
          buffer.writeln('• $value');
        } else if (value is Map) {
          buffer.writeln(_extractBackendErrors(value));
        }
      });
      return buffer.toString().trim();
    }

    return '';
  }

  static String _mapStatusCodeToMessage(int? statusCode, dynamic data) {
    switch (statusCode) {
      case 400:
        return '🚫 Bad request — please check your input.';
      case 401:
        return '🔐 Unauthorized — please log in again.';
      case 403:
        return '⛔ Forbidden — you do not have permission to access this resource.';
      case 404:
        return '❓ Not found — the requested resource doesn’t exist.';
      case 408:
        return '⏰ Request timeout — server took too long to respond.';
      case 409:
        return '⚠️ Conflict — duplicate request or resource already exists.';
      case 422:
        return '📋 Validation failed — please correct the highlighted fields.';
      case 500:
        return '💥 Internal server error — please try again later.';
      case 502:
        return '🚧 Bad gateway — invalid response from upstream server.';
      case 503:
        return '🛠 Service unavailable — server temporarily down.';
      case 504:
        return '⏳ Gateway timeout — server did not respond in time.';
      default:
        return '⚠️ Something went wrong — please try again.';
    }
  }
}
