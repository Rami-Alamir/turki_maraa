import 'dart:convert';
import 'package:http/http.dart' as http;
import 'app_exception.dart';
import '../../constants/constants.dart';

class ApiBaseHelper {
  final String _baseUrl = Constants.baseUrl;
  String authorization = "";
  Map<String, String> headers = {
    "Accept": "application/json",
    "App-Key": "Nghf9AP72aWF635xLHCnd9q88pRmSaP95BLRDI0n",
    "Authorization": ""
  };
  Map<String, String> headers2 = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "App-Key": "Nghf9AP72aWF635xLHCnd9q88pRmSaP95BLRDI0n",
    "Authorization": ""
  };

  Map<String, String> tabbyHeader = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer ${Constants.tabbyApiKey}",
    "X-Merchant-Code": ""
  };

  Future<dynamic> get(String url, {String authorization = " "}) async {
    headers['authorization'] = authorization;
    Uri uri = Uri.parse(_baseUrl + url);
    dynamic responseJson;
    try {
      var response = await http.get(uri, headers: headers);
      responseJson = _returnResponse(response);
    } catch (_) {}
    return responseJson;
  }

  Future<dynamic> get2(String url, {String authorization = " "}) async {
    headers['authorization'] = authorization;
    Uri uri = Uri.parse(_baseUrl + url);
    dynamic response;
    try {
      response = await http.get(uri, headers: headers);
    } catch (_) {}
    return response;
  }

  Future<int> post2(String url, Map<String, dynamic> body,
      {String authorization = " "}) async {
    headers['authorization'] = authorization;
    Uri uri = Uri.parse(_baseUrl + url);
    dynamic response;
    try {
      response = await http.post(uri, body: body, headers: headers);
    } catch (_) {}
    return response.statusCode;
  }

  Future<dynamic> post(String url, Map<String, dynamic> body,
      {String authorization = ''}) async {
    authorization = authorization;
    headers['authorization'] = authorization;
    Uri uri = Uri.parse(_baseUrl + url);
    dynamic response;
    try {
      response = await http.post(uri, body: body, headers: headers);
    } catch (_) {}
    return _returnResponse(response);
  }

  Future<dynamic> post3(String url, Map<String, dynamic> body,
      {String authorization = ''}) async {
    authorization = authorization;
    headers['authorization'] = authorization;
    Uri uri = Uri.parse(_baseUrl + url);
    dynamic response;
    try {
      response = await http.post(uri, body: body, headers: headers);
    } catch (_) {}
    return response;
  }

  Future<dynamic> post4(String url, body, {String authorization = " "}) async {
    headers2['authorization'] = authorization;
    Uri uri = Uri.parse(_baseUrl + url);
    dynamic response;
    try {
      response = await http.post(uri, body: body.toString(), headers: headers2);
    } catch (_) {}
    return response;
  }

  Future<dynamic> post5(
      {required String url,
      required body,
      required String merchantCode}) async {
    tabbyHeader['X-Merchant-Code'] = merchantCode;
    Uri uri = Uri.parse(url);
    dynamic response;
    try {
      response =
          await http.post(uri, body: json.encode(body), headers: tabbyHeader);
    } catch (_) {}
    return _returnResponse(response);
  }

  Future<int> delete(String url, {String authorization = " "}) async {
    headers['authorization'] = authorization;
    Uri uri = Uri.parse(_baseUrl + url);
    dynamic response;
    try {
      response = await http.delete(uri, headers: headers);
    } catch (_) {}
    return response.statusCode;
  }

  Future<int> get3(String url, {String authorization = " "}) async {
    headers['authorization'] = authorization;
    Uri uri = Uri.parse(_baseUrl + url);
    dynamic response;
    try {
      response = await http.get(uri, headers: headers);
    } catch (_) {}
    return response.statusCode;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        var responseJson = json.decode(response.body.toString());

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
