import 'dart:convert';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

class ApiBaseHelper {
  final String _baseUrl = 'turki.turkieshop.com';

  Map<String, String> headers = {
    "Accept": "application/json",
    "App-Key": "Nghf9AP72aWF635xLHCnd9q88pRmSaP95BLRDI0n"
  };

  Future<dynamic> get(String url, queryParameters) async {
    var uri = Uri.https(_baseUrl, url, queryParameters);
    var responseJson;
    try {
      var response = await http.get(uri, headers: headers);
      responseJson = _returnResponse(response);
    } catch (e) {}
    return responseJson;
  }

  Future<dynamic> post(String url, var body) async {
    var uri = Uri.https(_baseUrl, url);
    var responseJson;
    try {
      var response = await http.post(uri, body: body, headers: headers);
      responseJson = _returnResponse(response);
    } catch (e) {}
    return responseJson;
  }

  Future<dynamic> put(String url, var body) async {
    var uri = Uri.https(_baseUrl, url);
    var responseJson;
    try {
      var response = await http.put(uri, body: body, headers: headers);
      responseJson = _returnResponse(response);
    } catch (e) {}
    return responseJson;
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
