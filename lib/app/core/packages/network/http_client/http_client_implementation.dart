import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../shared/infrastructure/exceptions/server_exception.dart';
import '../../../utils/messages/states/core_state_messages.dart';
import 'http_client.dart';
import 'http_response.dart';

class HttpClientImplementation implements HttpClient {
  HttpClientImplementation(this.httpClient);

  final http.Client httpClient;

  @override
  Duration requestTimeout = const Duration(minutes: 3);

  @override
  Future<HttpResponse> get(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await httpClient
          .get(Uri.parse(url), headers: headers)
          .timeout(requestTimeout);
      String responseBody = utf8.decode(response.bodyBytes);
      List<int> characterCodes = responseBody.codeUnits;
      return HttpResponse(
        data: String.fromCharCodes(characterCodes),
        statusCode: response.statusCode,
      );
    } catch (exception) {
      throw const ServerException(
        message: CoreStateMessages.serverError,
        statusCode: 500,
      );
    }
  }

  @override
  Future<HttpResponse> post(
    String url, {
    dynamic body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await httpClient
          .post(
            Uri.parse(url),
            body: body,
            headers: headers,
          )
          .timeout(requestTimeout);

      return HttpResponse(data: response.body, statusCode: response.statusCode);
    } catch (exception) {
      throw const ServerException(
        message: CoreStateMessages.serverError,
        statusCode: 500,
      );
    }
  }

  @override
  Future<HttpResponse> put(
    String url, {
    body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await httpClient
          .put(
            Uri.parse(url),
            body: body,
            headers: headers,
          )
          .timeout(requestTimeout);

      return HttpResponse(data: response.body, statusCode: response.statusCode);
    } catch (exception) {
      throw const ServerException(
        message: CoreStateMessages.serverError,
        statusCode: 500,
      );
    }
  }

  @override
  Future<HttpResponse> formData(
    String url, {
    dynamic body,
    String httpMethod = 'POST',
    List<File>? files,
    File? file,
    Map<String, String>? headers,
  }) async {
    try {
      final request = http.MultipartRequest(httpMethod, Uri.parse(url));
      request.headers.addAll(headers!);
      if (body != null) {
        request.fields.addAll(Map<String, String>.from(jsonDecode(body!)));
      }
      if (files != null)
        for (final file in files) {
          request.files
              .add(await http.MultipartFile.fromPath('files', file.path));
        }
      if (file != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'file',
            file.path,
          ),
        );
      }
      final sendRequest =
          await request.send().timeout(const Duration(seconds: 180));
      final response = await http.Response.fromStream(sendRequest);
      return HttpResponse(data: response.body, statusCode: response.statusCode);
    } catch (exception) {
      throw const ServerException(
        message: CoreStateMessages.serverError,
        statusCode: 500,
      );
    }
  }

  @override
  Future<HttpResponse> delete(
    String url, {
    body,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await httpClient
          .delete(
            Uri.parse(url),
            body: body,
            headers: headers,
          )
          .timeout(requestTimeout);

      return HttpResponse(data: response.body, statusCode: response.statusCode);
    } catch (exception) {
      throw const ServerException(
        message: CoreStateMessages.serverError,
        statusCode: 500,
      );
    }
  }
}
