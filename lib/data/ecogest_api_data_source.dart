import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EcoGestApiDataSource {
  // static const _baseUrl = 'https://ecogest-api-ce3f0245de21.herokuapp.com/api';

  static const _baseUrl = "http://10.0.2.2:8080/api";

  static get baseUrl  {
    return _baseUrl;
  }

  // static const _baseUrl = "https://ecogest.onrender.com/api";

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

  static Future<bool> addImage(String endpoint, String filepath,
      {String? token}) async {

    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $token'
    };

    var request = http.MultipartRequest('POST', Uri.parse('$_baseUrl$endpoint'))
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', filepath));

    var response = await request.send();

    if (response.statusCode > 199 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }
}
