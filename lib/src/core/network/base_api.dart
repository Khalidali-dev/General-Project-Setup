import 'package:iserve/src/src.dart';

abstract class BaseAPIService {
  Future<Response> get(String url);
  Future<Response> post({
    required String url,
    required Map<String, dynamic> body,
  });
  Future<Response> patch({
    required String url,
    required Map<String, dynamic> body,
  });
  Future<Response> delete(String url);
}
