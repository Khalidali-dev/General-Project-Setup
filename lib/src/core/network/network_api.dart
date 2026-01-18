import 'dart:developer';

import 'package:iserve/src/src.dart';

class NetworkAPIService implements BaseAPIService {
  final Dio _dio = Dio();

  static final NetworkAPIService _instance = NetworkAPIService._internal();
  factory NetworkAPIService() => _instance;

  final String baseUrl = "https://demo.iserve.church/api/v1/";

  NetworkAPIService._internal() {
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers: {"accept": "application/json"},
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final loginResponse = await LocalStorageService.getLoginResponse();
          final token = loginResponse?.data?.token;
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          log('''
🚀 [API REQUEST STARTED]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔹 METHOD: ${options.method}
🔹 URL: ${options.uri}
🔹 HEADERS: ${options.headers}
🔹 BODY: ${options.data}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');

          handler.next(options);
        },
        onResponse: (response, handler) {
          log('''
✅ [API RESPONSE RECEIVED]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔹 STATUS: ${response.statusCode}
🔹 URL: ${response.requestOptions.uri}
🔹 DATA: ${response.data}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');
          handler.next(response);
        },
        onError: (DioException err, handler) {
          log('''
❌ [API ERROR]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔹 TYPE: ${err.type}
🔹 MESSAGE: ${err.message}
🔹 URL: ${err.requestOptions.uri}
🔹 STATUS: ${err.response?.statusCode}
🔹 DATA: ${err.response?.data}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
''');

          handler.next(err);
        },
      ),
    );
  }

  @override
  Future<Response> get(String url) async {
    try {
      return await _dio.get(url);
    } on DioException catch (e) {
      throw AppExceptionHandler.handle(e);
    }
  }

  @override
  Future<Response> post({required String url, required dynamic body}) async {
    try {
      return await _dio.post(url, data: body);
    } on DioException catch (e) {
      throw AppExceptionHandler.handle(e);
    }
  }

  @override
  Future<Response> delete(String url) async {
    try {
      return await _dio.delete(url);
    } on DioException catch (e) {
      throw AppExceptionHandler.handle(e);
    }
  }

  @override
  Future<Response> patch({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      return await _dio.patch(url, data: body);
    } on DioException catch (e) {
      throw AppExceptionHandler.handle(e);
    }
  }
}
