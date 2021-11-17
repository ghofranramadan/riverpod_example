import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:riverpod_test/network/client/ApiClient.dart';
import 'package:riverpod_test/utils/Enums.dart';

class NetworkCall {
  static Future<Map<String, dynamic>> makeCall({
    String endPoint,
    HttpMethod method,
    dynamic requestBody,
    Map<String, dynamic> queryParams,
    bool isMultipart = false,
  }) async {
    try {
      Response response;
      if (method == HttpMethod.GET) {
        response = (await ApiClient.getRequest(endPoint, queryParams));
      } else {
        response = (await ApiClient.postRequest(endPoint, requestBody,
            isMultipart: isMultipart));
      }

      if (response.statusCode == NetworkStatusCodes.OK_200.value) {
        //Api logger
        log("Api Response: ${response.body}");
        return jsonDecode(response.body);
      } else if (response.statusCode ==
              NetworkStatusCodes.ServerInternalError.value ||
          response.statusCode == NetworkStatusCodes.BadRequest.value) {
        //Api logger
        //log("API Error: ${response.statusCode} - ${response.reasonPhrase} - ${response.body}");
        log("API Error:${response.body}");

        return jsonDecode(response.body);
      } else if (response.statusCode ==
          NetworkStatusCodes.UnAuthorizedUser.value) {
        var result = jsonDecode(response.body) as Map<String, dynamic>;
        result['error']['code'] = response.statusCode;

        //Api logger
        log("API Error: ${response.statusCode} - ${response.reasonPhrase} - $result");
        return result;
      } else {
        //Api logger
        log("API Error: ${response.statusCode} - ${response.reasonPhrase} - ${response.body}");
        // return {
        //   "success": false,
        //   "error": {
        //     "code": response.statusCode,
        //     "message": response.reasonPhrase,
        //     "details": ""
        //   }
        // };
        return jsonDecode(response.body);
      }
    } on SocketException catch (_) {
      return {
        "success": false,
        "error": {
          "code": 0,
          "message":
              "No internet connection, please check you network and try again",
          "details": ""
        }
      };
    }
  }
}
