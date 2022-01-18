import 'dart:convert';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

class ApiBaseHelper {
  final String _baseUrl = 'https://almaraacompany.com/turki-api/api/v1/';
  String authorization = "";
  Map<String, String> headers = {
    "Accept": "application/json",
    // "Content-Type": "application/json",
    "App-Key": "Nghf9AP72aWF635xLHCnd9q88pRmSaP95BLRDI0n",
    "Authorization": ""
  };

  Future<dynamic> get(String url, {String authorization = " "}) async {
    headers['authorization'] = authorization;
    var uri = Uri.parse(_baseUrl + url);
    var responseJson;
    try {
      var response = await http.get(uri, headers: headers);
      responseJson = _returnResponse(response);
      print(responseJson.toString());
    } catch (e) {
      print(e.toString());
    }
    return responseJson;
  }

  Future<dynamic> get2(String url, {String authorization = " "}) async {
    headers['authorization'] = authorization;
    var uri = Uri.parse(_baseUrl + url);
    var responseJson;
    var response;
    try {
      response = await http.get(uri, headers: headers);
      responseJson = _returnResponse(response);
      print(responseJson.toString());
    } catch (e) {
      print(e.toString());
    }
    return response;
  }

  Future<dynamic> post(String url, var body) async {
    var uri = Uri.parse(_baseUrl + url);
    var responseJson;
    try {
      var response = await http.post(uri, body: body, headers: headers);
      responseJson = _returnResponse(response);
      print(responseJson);
    } catch (e) {}
    return responseJson;
  }

  Future<int> post2(String url, var body, {String authorization = " "}) async {
    headers['authorization'] = authorization;
    print(authorization);
    var uri = Uri.parse(_baseUrl + url);
    print(uri.toString());
    var response;
    try {
      response = await http.post(uri, body: body, headers: headers);
      print(_returnResponse(response));
    } catch (e) {
      print(e.toString());
    }
    return response.statusCode;
  }

  Future<dynamic> post3(String url, var body,
      {String authorization = ''}) async {
    authorization = authorization;
    headers['authorization'] = authorization;
    var uri = Uri.parse(_baseUrl + url);
    var response;
    try {
      response = await http.post(uri, body: body, headers: headers);
    } catch (e) {}
    return response;
  }

  Future<dynamic> put(String url, var body) async {
    var uri = Uri.parse(_baseUrl + url);
    var responseJson;
    try {
      var response = await http.put(uri, body: body, headers: headers);
      responseJson = _returnResponse(response);
    } catch (e) {}
    return responseJson;
  }

  Future<int> delete(String url, {String authorization = " "}) async {
    headers['authorization'] = authorization;
    print(authorization);
    var uri = Uri.parse(_baseUrl + url);
    print(uri.toString());
    var response;
    try {
      response = await http.delete(uri, headers: headers);
      print(_returnResponse(response));
    } catch (e) {
      print(e.toString());
    }
    return response.statusCode;
  }

  Future<int> get3(String url, {String authorization = " "}) async {
    headers['authorization'] = authorization;
    print(authorization);
    var uri = Uri.parse(_baseUrl + url);
    print(uri.toString());
    var response;
    try {
      response = await http.get(uri, headers: headers);
      print(_returnResponse(response));
    } catch (e) {
      print(e.toString());
    }
    return response.statusCode;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
