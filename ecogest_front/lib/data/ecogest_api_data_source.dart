import 'dart:convert';
import 'dart:async';

import 'package:http/http.dart' as http;

class EcoGestApiDataSource {
  static const _baseUrl = 'http://augustinseguin-server.eddi.cloud:9080/api';

  static Map<String, String> _getHeaders(String? token) {
    return <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      if (token != null) 'Authorization': 'Bearer $token'
    };
  }

  static Future<dynamic> get(String endpoint,
      {String error = 'Failed to load data', String? token}) async {
    /// In debug mode, assert that the endpoint starts with a /
    assert(endpoint.startsWith('/'), 'Endpoint must start with a /');

    var response = await http.get(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _getHeaders(token),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(error);
    }
  }

  static Future<dynamic> post(String endpoint, Object body,
      {String error = 'Failed to post data', String? token}) async {
    /// In debug mode, assert that the endpoint starts with a /
    assert(endpoint.startsWith('/'), 'Endpoint must start with a /');

    var response = await http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: _getHeaders(token),
      body: jsonEncode(body),
    );

    if (response.statusCode > 199 && response.statusCode <= 299) {
      return jsonDecode(response.body);
    } else {
      throw Exception(error);
    }
  }
}
