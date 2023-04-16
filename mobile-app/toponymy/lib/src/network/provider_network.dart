import 'dart:io';
import 'dart:convert';
import './exception_network.dart';
import 'package:toponymy/src/constant/constant.dart';

class ProviderNetwork {
  Future<dynamic> get(String path) async {
    dynamic responseJson;
    try {
      HttpClient client = new HttpClient()
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) => ignoreSSL);

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
        String responseJson = await response.transform(utf8.decoder).join();
        return responseJson;
      case 400:
        print("400");
        throw BadRequestException(response.transform(utf8.decoder).toString());
      case 401:

      case 403:
        print("401 403");
        throw UnauthorisedException(response.transform(utf8.decoder).toString());
      case 500:

      default:
        print("500 default");
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