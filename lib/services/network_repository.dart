import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future callPostMethod(
    BuildContext mContext, String url, Map<String, dynamic> params) async {
  return http
      .post(Uri.https('vrksh-vaatika-backend.azurewebsites.net', url),
          body: jsonEncode(params), headers: commonHeaders)
      .then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 401) {
      return 'Error statusCode';
    } else if (statusCode < 200 || statusCode > 404 || json == null) {
      return 'Error statusCode';
    }
    return response.body;
  });
}

Future callPostMethodWithToken(BuildContext mContext, String url,
    Map<String, dynamic> params, String token) async {
  return http.post(Uri.https('vrksh-vaatika-backend.azurewebsites.net', url),
      body: jsonEncode(params),
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
        "lancode": "en",
        "platform": Platform.operatingSystem,
        "Authorization": "Bearer " + token
      }).then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 401) {
      return 'Error statusCode';
    } else if (statusCode < 200 || statusCode > 404 || json == null) {
      return 'Error statusCode';
    }
    return response.body;
  });
}

Future callPostMethodNoBodyToken(
    BuildContext mContext, String url, String token) async {
  var header = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'lancode': 'en',
    "platform": Platform.operatingSystem,
    "Authorization": token,
    "appversion": "1.0.1",
  };
  return http
      .post(Uri.http('parkshark.demoserver23.com', url), headers: header)
      .then((http.Response response) {
    final int statusCode = response.statusCode;
    print(response.statusCode.toString());
    if (statusCode == 401) {
      return 'Error statusCode';
    } else if (statusCode < 200 || statusCode > 404 || json == null) {
      return 'Error statusCode';
    }
    return response.body;
  });
}

Future callGetMethod(
    BuildContext mContext, String url, Map params, String token) async {
  commonHeaders['Authorization'] = 'Bearer ' + token;
  return await http
      .get(
          Uri.https(
            'vrksh-vaatika-backend.azurewebsites.net',
            url,
          ),
          headers: commonHeaders)
      .then((http.Response response) {
    final int statusCode = response.statusCode;
    if (statusCode == 401) {
      return 'Error statusCode';
    } else if (statusCode < 200 || statusCode > 404 || json == null) {
      return 'Error statusCode';
    }
    return response.body;
  });
}

void printWrapped(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((match) => print(match.group(0))); // uncomment this for testing
}

Map<String, String> commonHeaders = {
  'Accept': 'application/json',
  'Content-Type': 'application/json',
  "os": Platform.operatingSystem,
};
