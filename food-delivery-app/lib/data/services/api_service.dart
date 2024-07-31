import 'dart:convert';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:reflectable/reflectable.dart';

class APIService<T> {
  final String endpoint;
  final String? fullUrl;
  final Token? token;
  final String queryParams;
  final String retrieveQueryParams;
  final bool pagination;
  final bool fullResponse;

  APIService({
    this.token,
    this.queryParams = '',
    this.fullUrl,
    this.retrieveQueryParams = '',
    this.pagination = true,
    this.fullResponse = false,
  }) : endpoint = APIConstant.getEndpointFor<T>() ?? "";

  T Function(Map<String, dynamic>) get fromJson {
    var classMirror = jsonSerializable.reflectType(T) as ClassMirror;
    var constructor = classMirror.declarations["fromJson"];
    return (json) => classMirror.newInstance("fromJson", [json]) as T;
  }

  String url({String id = ''}) {
    return '${APIConstant.baseUrl}/$endpoint/${id != '' ? '$id/' : ''}';
  }

  Future<List<T>> list() async {
    final url_ = fullUrl ?? url() + queryParams;
    final response = await http.get(
      Uri.parse(url_),
      headers: _getHeaders(),
    );
    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);
      if (pagination) {
        jsonResponse = jsonResponse["results"];
      }
      return (jsonResponse as List).map((instance) => fromJson(instance)).toList();
    } else {
      throw Exception('Failed to get data: ${response.statusCode}');
    }
  }

  Future<T> retrieve(String id) async {
    final url_ = fullUrl ?? url(id: id) + retrieveQueryParams;
    final response = await http.get(
      Uri.parse(url_),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return fromJson(jsonResponse);
    } else {
      throw Exception('Failed to get data: ${response.statusCode}');
    }
  }

  Future<dynamic> create(dynamic data, { Function(Map<String, dynamic>)? fromJson }) async {
    final response = await http.post(
      Uri.parse(url()),
      headers: _getHeaders(),
      body: json.encode(data.toJson()),
    );
    var jsonResponse = json.decode(response.body);
    print(response.body);
    if(fromJson != null) {
      jsonResponse = fromJson(jsonResponse);
    }
    return [response.statusCode, response.headers, jsonResponse];
  }

  Future<dynamic> update(String? id, dynamic data) async {
    final response = await http.put(
      Uri.parse(url(id: id!)),
      headers: _getHeaders(),
      body: json.encode(data.toJson()),
    );
    return [response.statusCode, response.headers, fromJson(json.decode(response.body))];
  }

  Future<void> delete(String id) async {
    final response = await http.delete(
      Uri.parse(url(id: id)),
      headers: _getHeaders(),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete object: ${response.statusCode}');
    }
  }

  Map<String, String> _getHeaders() {
    final headers = {'Content-Type': 'application/json'};
    if (token?.access != null && token!.access.isNotEmpty) {
      headers['Authorization'] = 'Bearer ${token!.access}';
    }
    return headers;
  }
}
