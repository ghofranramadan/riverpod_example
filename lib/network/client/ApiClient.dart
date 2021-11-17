import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:riverpod_test/utils/TokenUtil.dart';

import '../ServicesURLs.dart';

class ApiClient {
  static Map<String, String> headers() {
    var mHeaders = {
      HttpHeaders.acceptHeader: 'application/json',
      // HttpHeaders.connectionHeader: 'keep-alive',
      // HttpHeaders.cacheControlHeader: 'no-cache',
      HttpHeaders.contentTypeHeader: 'application/json',
      //"Abp.TenantId": '1'
    };
    // mHeaders["Accept-Language"] =
    //     SettingsSession.instance().languageCode != null
    //         ? SettingsSession.instance().languageCode
    //         : "en";
    // mHeaders[".AspNetCore.Culture"] =
    //     SettingsSession.instance().languageCode != null
    //         ? SettingsSession.instance().languageCode
    //         : "en";
    // loading auth token
    if (TokenUtil.getTokenFromMemory().isNotEmpty) {
      mHeaders[HttpHeaders.authorizationHeader] =
          "Bearer ${TokenUtil.getTokenFromMemory()}";
    }

    return mHeaders;
  }

  static Future<Response> getRequest(
      String endPoint, Map<String, dynamic> queryParams) async {
    //create url with (baseUrl + endPoint) and query Params if any
    Uri url = Uri(
        scheme: ServicesURLs.development_environment_scheme,
        host: ServicesURLs.development_environment_without_http,
        //   port: ServicesURLs.development_environment_port,
        path: endPoint,
        queryParameters: queryParams);

    //network logger
    print(url.toString() + "\n" + headers().toString());
    print(url.queryParameters.toString());
    //GET network request call
    final response = await http.get(url, headers: headers());

    return response;
  }

  static Future<http.Response> postRequest(String endPoint, dynamic requestBody,
      {bool isMultipart = false}) async {
    //create url of (baseUrl + endPoint)
    String url = ServicesURLs.development_environment + endPoint;
    //network logger
    print(url + "\n" + headers().toString());
    if (requestBody != null) log(requestBody.toString());
    //POST network request call

    var response;
    if (!isMultipart) {
      log("**InideNotMultiPart**");
      response = await http.post(Uri.parse(url),
          headers: headers(), body: requestBody);
    } else {
      var uri = Uri.parse(url);
      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers())
        ..files.add(await http.MultipartFile.fromPath(
          '',
          requestBody.path,
        ));
      response = await http.Response.fromStream(await request.send());
    }

    return response;
  }
}
