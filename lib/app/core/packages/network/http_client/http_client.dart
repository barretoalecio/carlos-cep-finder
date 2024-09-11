import 'dart:io';

import 'http_response.dart';

abstract class HttpClient {
  Duration requestTimeout = const Duration(seconds: 10);

  Future<HttpResponse> get(String url, {Map<String, String>? headers});

  Future<HttpResponse> post(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  });

  Future<HttpResponse> put(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  });

  Future<HttpResponse> formData(
    String url, {
    dynamic body,
    String httpMethod,
    List<File>? files,
    File? file,
    Map<String, String>? headers,
  });

  Future<HttpResponse> delete(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  });
}
