import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiClient {
  final String appBaseUrl;

  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;
  Map<String, String>? _mainHeaders;

  ApiClient({
    required this.appBaseUrl,
  }) {
    updateHeader();
  }

  void updateHeader() {
    _mainHeaders = {
      // 'Authorization': 'Bearer ${storage.read(AppConstants.TOKEN)}',
      'secret-key': 'KoztJyHBeFWWPziUeBAr'
    };
  }

  Future<ApiResponse> getData(String uri,
      {Map<String, dynamic>? query,
        Map<String, String>? headers,
        bool? url}) async {
    try {
      final fullUrl = (url == true
          ? uri + "${uri.contains("?") ? "" : "?"}"
          : appBaseUrl + uri + "${uri.contains("?") ? "" : "?"}");

      log('====> API Call: $fullUrl\n Header: $headers');
      http.Response _response = await http
          .get(
        Uri.parse(fullUrl),
        headers: headers ?? _mainHeaders,
      )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, fullUrl);
    } on TimeoutException catch (e) {
      return ApiResponse(statusCode: 1, statusText: e.toString(), body: null);
    } catch (e) {
      return ApiResponse(statusCode: 1, statusText: e.toString(), body: null);
    }
  }



  Future<ApiResponse> postData(String uri, dynamic body,
      {Map<String, String>? headers, bool? url}) async {
    try {
      log('====> API Call: $uri\nHeader: $headers');
      log('====> API Body: $body');
      log(appBaseUrl + uri);
      http.Response _response = await http
          .post(
        Uri.parse(url == true ? uri : appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } on TimeoutException catch (e) {
      return ApiResponse(statusCode: 1, statusText: e.toString(), body: null);
    } catch (e) {
      log(e.toString());
      return ApiResponse(statusCode: 1, statusText: e.toString(), body: null);
    }
  }

  Future<ApiResponse> putData(String uri, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      log('====> API Call: $uri\nHeader: $headers');
      log('====> API Body: $body');
      http.Response _response = await http
          .put(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: headers ?? _mainHeaders,
      )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } on TimeoutException catch (e) {
      return ApiResponse(statusCode: 1, statusText: e.toString(), body: null);
    } catch (e) {
      return ApiResponse(statusCode: 1, statusText: e.toString(), body: null);
    }
  }

  Future<ApiResponse> deleteData(String uri,
      {Map<String, String>? headers}) async {
    try {
      log('====> API Call: $uri\nHeader: $_mainHeaders');
      http.Response _response = await http
          .delete(
        Uri.parse(appBaseUrl + uri),
        headers: headers ?? _mainHeaders,
      )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(_response, uri);
    } on TimeoutException catch (e) {
      return ApiResponse(statusCode: 1, statusText: e.toString(), body: null);
    } catch (e) {
      return ApiResponse(statusCode: 1, statusText: e.toString(), body: null);
    }
  }

  ApiResponse handleResponse(http.Response response, String uri) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {
      log(e.toString());
    }

    if (response.statusCode == 401) {
      // Handle unauthorized
      // Add your own logic here (e.g., logout, refresh token, etc.)
    } else if (response.statusCode == 429 || response.statusCode == 500) {
      // Handle specific error codes
      // Add your own logic here
    }

    log('====> API Response: [${response.statusCode}] $uri\n${response.body}');
    return ApiResponse(
      body: _body ?? response.body,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
  }
}

class ApiResponse {
  final dynamic body;
  final int? statusCode;
  final String? statusText;

  ApiResponse({
    required this.body,
    this.statusCode,
    this.statusText,
  });
}

