import 'dart:convert';
import 'package:food_delivery_app/data/services/reflect.dart';
import 'package:food_delivery_app/features/authentication/models/auth/token.dart';
import 'package:food_delivery_app/utils/constants/api_constants.dart';
import 'package:food_delivery_app/data/services/token_service.dart';
import 'package:food_delivery_app/utils/helpers/helper_functions.dart';
import 'package:http/http.dart' as http;
import 'package:reflectable/reflectable.dart';

class APIService<T> {
  final String? endpoint;
  final String fullUrl;
  final String queryParams;
  final String retrieveQueryParams;
  final bool pagination;
  final bool fullResponse;

  APIService({
    this.endpoint,
    this.queryParams = '',
    this.fullUrl = '',
    this.retrieveQueryParams = '',
    this.pagination = true,
    this.fullResponse = false,
  });

  T Function(Map<String, dynamic>) get fromJson {
    var classMirror = jsonSerializable.reflectType(T) as ClassMirror;
    var constructor = classMirror.declarations["fromJson"];
    return (json) => classMirror.newInstance("fromJson", [json]) as T;
  }

  String url({dynamic id}) {
    String url = fullUrl.isNotEmpty ? fullUrl : '${APIConstant.baseUrl}/${endpoint ?? APIConstant.getEndpointFor<T>() ?? ""}';
    url += (url.endsWith('/')) ? '' : '/';

    if (id != null) {
      url += '$id/';
    }

    if (queryParams.isNotEmpty) {
      url += '?$queryParams';
    }

    if (retrieveQueryParams.isNotEmpty) {
      url += (queryParams.isNotEmpty ? '&' : '?') + retrieveQueryParams;
    }

    return url;
  }

  Future<dynamic> list() async {
    return _handleRequest<dynamic>((Token? token) async {
      final url_ = url();
      final response = await http.get(
        Uri.parse(url_),
        headers: await _getHeaders(token),
      );
      $print(url_);
      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);
        if (pagination) {
          jsonResponse = jsonResponse["results"];
        }
        if (jsonResponse is Map<String, dynamic>) {
          return fromJson(jsonResponse);
        }
        return (jsonResponse as List).map((instance) => fromJson(instance)).toList();
      } else {
        throw http.ClientException('Failed to get data: ${response.statusCode}');
      }
    });
  }

  Future<T> retrieve(String id) async {
    return _handleRequest<T>((Token? token) async {
      final url_ = url(id: id);
      final response = await http.get(
        Uri.parse(url_),
        headers: await _getHeaders(token),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return fromJson(jsonResponse);
      } else {
        throw Exception('Failed to get data: ${response.statusCode}');
      }
    });
  }

  Future<dynamic> create(dynamic data, { Function(Map<String, dynamic>)? fromJson }) async {
    return _handleRequest<dynamic>((Token? token) async {
      final response = await http.post(
        Uri.parse(url()),
        headers: await _getHeaders(token),
        body: json.encode(data.toJson()),
      );
      var jsonResponse = json.decode(response.body);
      if(fromJson != null) {
        jsonResponse = fromJson(jsonResponse);
      }
      return [response.statusCode, response.headers, jsonResponse];
    });
  }

  Future<dynamic> update(dynamic id, dynamic data, { Function(Map<String, dynamic>)? fromJson, bool patch = false }) async {
    return _handleRequest<dynamic>((Token? token) async {
      final uri = Uri.parse(url(id: id!));
      final headers = await _getHeaders(token);
      final body = json.encode((data is Map<String, dynamic>) ? data : data.toJson(patch: patch));

      final response = patch
          ? await http.patch(uri, headers: headers, body: body)
          : await http.put(uri, headers: headers, body: body);

      var jsonResponse = json.decode(response.body);
      if (fromJson != null) {
        jsonResponse = fromJson(jsonResponse);
      }
      return [response.statusCode, response.headers, jsonResponse];
    });
  }

  Future<void> delete(String id) async {
    return _handleRequest<void>((Token? token) async {
      final response = await http.delete(
        Uri.parse(url(id: id)),
        headers: await _getHeaders(token),
      );

      if (response.statusCode != 204) {
        throw Exception('Failed to delete object: ${response.statusCode}');
      }
    });
  }

  Future<R> _handleRequest<R>(Future<R> Function(Token?) request) async {
    Token? token;
    try {
      token = await TokenService.getToken();
      return await request(token);
    } catch (e) {
      await refreshToken();
      token = await TokenService.getToken();
      return await request(token);
    }
  }

  Future<void> refreshToken() async {
    Token? token = await TokenService.getToken();
    final response = await http.post(
      Uri.parse('${APIConstant.baseUrl}/account/refresh-token/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'refresh': token?.refresh}),
    );
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      token?.access = jsonResponse["access"] ?? "";
      await TokenService.saveToken(token!);
    } else {
      throw Exception('Failed to refresh token: ${response.statusCode}');
    }
  }

  Future<Map<String, String>> _getHeaders(Token? token) async {
    final headers = {'Content-Type': 'application/json'};
    if (token?.access != null && token!.access.isNotEmpty) {
      headers['Authorization'] = 'Bearer ${token.access}';
    }
    return headers;
  }
}