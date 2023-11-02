import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class EcoGestApiDataSource {
  static const _baseUrl = 'http://localhost:8080/api';

  /// In this example, we use the Flutter Secure Storage plugin to
  /// store the token
  static const storage = FlutterSecureStorage();

  /// The key used to store the token in the local storage
  static const key = 'token';

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

    static Future<dynamic> patch(String endpoint, Object body,
      {String error = 'Failed to patch data', String? token}) async {
    /// In debug mode, assert that the endpoint starts with a /
    assert(endpoint.startsWith('/'), 'Endpoint must start with a /');

    var response = await http.patch(
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


  static Future<String> getToken() async {
    String? token = await storage.read(key: key);

    if (token == null) {
      throw Exception('Token not found in local storage');
    }

    return token;
  }

  static Future<dynamic> delete(String endpoint, Object body,
      {String error = 'Failed to delete data', String? token}) async {
    /// In debug mode, assert that the endpoint starts with a /
    assert(endpoint.startsWith('/'), 'Endpoint must start with a /');

    var response = await http.delete(
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
