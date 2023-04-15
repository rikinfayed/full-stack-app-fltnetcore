import 'dart:io';
import 'dart:convert';
import './exception_network.dart';
import 'package:toponymy/src/constant/constant.dart';

class ProviderNetwork {
  Future<dynamic> get(String path) async {
    var responseJson;
    try {
      HttpClient client = new HttpClient()
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);

      HttpClientRequest request = await client.openUrl(
          'GET', Uri.parse(REST_URL + path));

      HttpClientResponse response = await request.close();
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(HttpClientResponse response) async {
    switch (response.statusCode) {
      case 200: 
        String reply = await response.transform(utf8.decoder).join();
        Map<String, dynamic> jsonObject = json.decoder.convert(reply);
        var responseJson = jsonObject;

        return responseJson;
      case 400:
        throw BadRequestException(response.transform(utf8.decoder).toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.transform(utf8.decoder).toString());
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  // get private _instance
  static final ProviderNetwork _instance = ProviderNetwork._();

  //constructor generate method
  ProviderNetwork._();

  //called external
  factory ProviderNetwork() {
    return _instance;
  }
}