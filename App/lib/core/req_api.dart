import 'dart:isolate';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:anysynx/core/logger.dart' show appLog, LogLevel;

class ApiService {
  static Future<String> get(String url) => fetchGet(url);

  static Future<String> post(String url, Map<String, dynamic> json) => fetchPost(url, json);
}

Future<String> fetchGet(String url) async {
  return await Isolate.run(() async {
    try {
      appLog("FETCH", ("Mengambil data dari url $url"), level: LogLevel.info);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        appLog("FETCH", ("Status code ${response.statusCode}"), level: LogLevel.info);
        return response.body;
      } else {
        return "error: ${response.statusCode}";
      }
    } catch (e) {
      return "error: $e";
    }
  });
}

Future<String> fetchPost(String url, Map<String, dynamic> json) async {
  return await Isolate.run(() async {
    try {
      appLog("FETCH", ("Mengambil data dari url $url"), level: LogLevel.info);
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "User-Agent":
              "Mozilla/5.0 (Windows NT 10.0; Win64; x64) Chrome/145.0.0.0",
        },
        body: jsonEncode(json),
      );

      if (response.statusCode == 200) {
        appLog("FETCH", ("Status code ${response.statusCode}"), level: LogLevel.info);
        return response.body;
      } else {
        return "error: ${response.statusCode}";
      }
    } catch (e) {
      return "error: $e";
    }
  });
}