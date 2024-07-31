import 'dart:convert';
import 'package:food_delivery_app/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class APIService {
  final String? endpoint;
  final String? fullUrl;
  final String token;

  APIService({
    this.endpoint, this.fullUrl, required this.token
  });

  String url({String id = ''}) {
    return '${APIConstant.baseUrl}/$endpoint/${id != '' ? '$id/' : ''}';
  }

  Future<List<dynamic>> fetchList(final modelFromJson,
      {
        String queryParams = "",
        bool pagination = false,
      }
      ) async {
    final url_ = (endpoint != null ? url() + queryParams : fullUrl ?? "" );
    final response = await http.get(
      Uri.parse(url_),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);
      if(pagination == true) {
        jsonResponse = jsonResponse["results"];
      }
      return (jsonResponse as Iterable).map((instance) => modelFromJson(instance)).toList();
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<dynamic> fetchSingle(final modelFromJson, String? id, { String queryParams = "" }) async {
    final url_ = (endpoint != null ? url(id: id!) : fullUrl ?? "" ) + queryParams;
    final response = await http.get(
      Uri.parse(url_),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return modelFromJson(jsonResponse);
    } else {
      throw Exception('Failed to get data');
    }
  }

  Future<dynamic> create(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(url()),
      headers: _getHeaders(),
      body: json.encode(data),
    );
    return [response.statusCode, response.headers, json.decode(response.body)];
    if (response.statusCode == 201 || response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      return response;
      // throw Exception(response.statusCode);
    }
  }

  Future<dynamic> update(String? id, Map<String, dynamic> data) async {
    final response = await http.put(
      Uri.parse(url(id: id!)),
      headers: _getHeaders(),
      body: json.encode(data),
    );
    return [response.statusCode, response.headers, json.decode(response.body)];
  }

  Future<dynamic> delete(String? id) async {
    final response = await http.delete(
      Uri.parse(url(id: id!)),
      headers: _getHeaders(),
    );

    if (response.statusCode == 204) {
      print("Successful");
      // return;
    } else {
      throw Exception('Failed to delete object');
    }
    return [response.statusCode];
  }


  Map<String, String> _getHeaders() {
    // if (token != null) {
    return (token != "") ? {
      'Content-Type': 'application/json',
      'Authorization': 'TOKEN $token',
    } : {
      'Content-Type': 'application/json'
    };
  }
}


Future<dynamic> callCreateAPI(
    String endpoint,
    modelToJson,
    String token,
    {
      bool fullResponse = false,
    }
    ) async {
  APIService service = APIService(endpoint: endpoint, token: token);
  if(fullResponse) {
    return await service.create(modelToJson);
  }
  return (await service.create(modelToJson))[2];
}

Future<dynamic> callUpdateAPI(
    String? endpoint,
    String? id,
    modelToJson,
    String token,
    {
      bool fullResponse = false
    }
    ) async {
  APIService service = APIService(endpoint: endpoint, token: token);
  if(fullResponse) {
    return await service.update(id, modelToJson);
  }
  return (await service.update(id, modelToJson))[2];
}
